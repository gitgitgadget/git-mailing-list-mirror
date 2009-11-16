From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git am and CRLF files
Date: Mon, 16 Nov 2009 12:43:36 +0100
Message-ID: <40aa078e0911160343k41393197s56d26576bcbfbe90@mail.gmail.com>
References: <4AFD2A8F.7000806@atlas-elektronik.com>
	 <4B01004A.8060600@atlas-elektronik.com>
	 <20091116195036.6117@nanako3.lavabit.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 12:43:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9zzl-0006Ea-U9
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 12:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbZKPLnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 06:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZKPLnc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 06:43:32 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:61387 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZKPLnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 06:43:31 -0500
Received: by fxm21 with SMTP id 21so2572885fxm.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3NwAPI4KdAY35SNYs23VorJpEJGqjrp7lhMifG4+6KE=;
        b=u1k/vg5p5nQCXCs8jby+0e3In9Uipr6W/oyF11dnw1nYmFoMt4YVOYO7Qhkfv/wPea
         Zbb8y9k7vHY8z3QWs82y4XBS4uu/fiGfEGW++CZtUBiWSchFduCk1eeKtkome3NQNXVX
         /HbgfV7SkZHXfI/VSpUoomPGASaBNW8YO8qW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=L97Xj6F3eXZYVjpftduwMBKlUvLVFu6uVRsLhr0UMrnhmV6EcJCEo8GYMt6lYAxX9/
         cf5zs0wW8CoXh+uxGNv4lni64LToey3996p+8dI+Cam8sU11mYMGFxv9QVOcita8oGqQ
         A/Nz7NsnoXots+d8w0Hu0mZT4Wo10k4sgOl2E=
Received: by 10.216.87.140 with SMTP id y12mr1900504wee.4.1258371816222; Mon, 
	16 Nov 2009 03:43:36 -0800 (PST)
In-Reply-To: <20091116195036.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133002>

On Mon, Nov 16, 2009 at 11:50 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Stefan Naewe <stefan.naewe@atlas-elektronik.com>
>
>>> A repository with some UNIX (LF) and some Windows (CRLF) files.
>>> (and no: I will not change the files. My editors handle CRLF and LF correctly)
>>>
>>> My problem:
>>>
>>> 'git am' can't handle changes in CRLF files because the patch
>>> gets converted (by git mailsplit) to contain only LF.
>>
>>> Stefan
>>
>> Does anyone have any comment on this ?
>
> This was done very much on purpose.
>
> The "am" command is meant to handle e-mailed patches, and traditionally
> mails are known to clobber carriage returns.
>

According to RFC 5322, email messages use CRLF as the
newline-sequence. In order to be able to distinguish between CRLF and
LF in an e-mail patch, the message needs to be use some
transfer-encoding that preserves newline style (like base64).

Perhaps this would be better fixed by having format-patch (or prehaps
the MUA ?) base64-encode the message body if the file contains
non-LF-newlines, and normalizing CRLF to LF before transport-decoding?
Or does some MUAs transport-decode before storing the message to disk?

I realize this might make it a bit tricky to review patches that
contains CRLF-newlines before mailing them out, but perhaps inspecting
the format-patch output is the wrong place to do this?

-- 
Erik "kusma" Faye-Lund
