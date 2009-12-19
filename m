From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Fri, 18 Dec 2009 18:24:26 -0800
Message-ID: <4B2C395A.6080300@gmail.com>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>  <1261172078-9174-1-git-send-email-bebarino@gmail.com>  <loom.20091218T223918-175@post.gmane.org> <1261173577.14059.5.camel@swboyd-laptop> <loom.20091218T234129-280@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 03:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLozj-0005wN-Bg
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 03:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbZLSCYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 21:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755878AbZLSCYa
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 21:24:30 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39914 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877AbZLSCY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 21:24:29 -0500
Received: by yxe17 with SMTP id 17so3475603yxe.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 18:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=2s7Sen7RsTGHFjL99zq4qnOYC+1dlUeCgFVSzkkF4SE=;
        b=xXKzMIcbwynzlC/gbppekh2rmVaTTz1hgWwnsPVBjpUoMzp5/xG1R2ZhfS7LD518OR
         syQ4yl6av7duMISRnQdchuNhPmD6Frum+Aj5n2qBeLwGoSJJwrSsPK0jzzd6o9IQhNG+
         fpauTAdwVBIR8Ys7NshvVvgdHeR1l/A4MGblo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lq0+3dQS7yH2JmnrCszvIdKu5gCgekpDz9Q4N3DW8uEIVPRwCZPaEmUKJN8wZNvasM
         vuvBCEOHeOeo67H0KK9NgMkZlRc2TNVHMYa/cgGDIbELD4z7Ovr682IglLrRN6OM1Flg
         7s2R9WZlj2eJ7T+JCjCiyxK6LNF/Tngey/iCw=
Received: by 10.151.88.34 with SMTP id q34mr7617792ybl.124.1261189469385;
        Fri, 18 Dec 2009 18:24:29 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 4sm1619641yxd.52.2009.12.18.18.24.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 18:24:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <loom.20091218T234129-280@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135456>

On 12/18/2009 02:42 PM, Eric Blake wrote:
> Stephen Boyd<bebarino<at>  gmail.com>  writes:
>>> echo and \ do not portably mix.  For that matter, shell double quotes and
>>> backslash escapes that are not required by POSIX do not portably mix.
>>
>> Thanks. Hopefully squashing this in will make it even more portable?
>>
>> +               printf "X-Fake-Field: Line One\015\n"&&
>
> Nope.  You need either "\\015\\n" or '\015\n', since "\015" and "\n" are both
> undefined in portable shell.

So, how about this?

         {
                 echo "X-Fake-Field: Line One"&&
                 echo "X-Fake-Field: Line Two"&&
                 echo "X-Fake-Field: Line Three"&&
                 git format-patch --stdout first | sed -e "1d"
         } | sed -e "s/$/;/" | tr "'";"'" "'"\015"'">  patch1-crlf.eml

Or maybe this?

         {
                 echo "X-Fake-Field: Line One"&&
                 echo "X-Fake-Field: Line Two"&&
                 echo "X-Fake-Field: Line Three"&&
                 git format-patch --stdout first | sed -e "1d"
         } | sed -e "s/$/;/" | tr ";" "\\015">  patch1-crlf.eml
