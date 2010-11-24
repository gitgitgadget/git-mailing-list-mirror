From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] mingw: do not set errno to 0 on success
Date: Wed, 24 Nov 2010 10:54:03 +0100
Message-ID: <AANLkTi=8OnTJHgX3-g9uqLX2B3+eUQf0uykynrwW3L4E@mail.gmail.com>
References: <1290541988-4608-1-git-send-email-kusmabite@gmail.com> <7v4ob7vb1m.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, j6t@kdbg.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 10:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLC3c-00078E-Fj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 10:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab0KXJy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 04:54:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57683 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0KXJyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 04:54:25 -0500
Received: by fxm13 with SMTP id 13so4793912fxm.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 01:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=d6tOgQ9O7Dj3Qnxf+FrsVc8QfEPnkV+mbGsjExf1xxc=;
        b=ihdOgpGXC54zwSjmuHfUewhKb8r5HrXYAg40M/V7QunPCDtxNLu4LeqVapug/w/Y4s
         v4QSNbzGNi6q1KLJzT+PdjMt2LtZJa8aa57r62jHfzxIQAJwClVGpWhTXz36l5p4+6e6
         sU+BonrlsKUZtiNtx3yVqviUIcO3Gwr6AEXiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=MPINoUtn/7fME4GJpLz1vd1XJ3fEstUQ7z3Kp954NJ+u4ewDhhKubZ80imBdxPTSDy
         aJ3JJmV2tEA94/5zoxruq7Own1EHHsM34ZdzZYK17xVN4fx2a+Xwk2UjVFSSVTsNaDVk
         hCfOaLS3DYhOYV9ZWzP8VMPPz+40HC5gF5OpQ=
Received: by 10.223.107.16 with SMTP id z16mr1137962fao.7.1290592464034; Wed,
 24 Nov 2010 01:54:24 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Wed, 24 Nov 2010 01:54:03 -0800 (PST)
In-Reply-To: <7v4ob7vb1m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162056>

On Wed, Nov 24, 2010 at 1:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Currently do_lstat always sets errno to 0 on success. This incorrectly
>> overwrites previous errors.
>>
>> Fetch the error-code into a temporary variable instead, and assign that
>> to errno on failure.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> A bug I found while hunting down another regression. maint-worthy, perhaps?
>
> I would say so, as long as the error return from get_file_attr() is
> trustworthy.

It looks trustworthy to me; it returns 0 if GetFileAttributesExA
succeeds, and either EACCES, ENAMETOOLONG, ENOMEM or ENOENT based on
the result of GetLastError().
