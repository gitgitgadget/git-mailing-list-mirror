From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/9] remote-hg: use hashlib instead of hg sha1 util
Date: Thu, 25 Apr 2013 14:30:48 -0500
Message-ID: <CAMP44s2et3sCgtdEbQzo3VTmAE=9-RCXQn2eQKtU6b2HPk0Vhw@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-6-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=Q2KZPioYD21pYLzruBnFh_cpFLh_rDj7QDa3bOaCO6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:30:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRsd-0001jD-6m
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807Ab3DYTau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:30:50 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36189 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab3DYTat (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:30:49 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so3121557lbi.28
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RRIU39Nv2H8CE8p4S7n+2KyXTFN+enqEn/h2v0jIufk=;
        b=YOj/QOfwIWpDxP8hEunWpmXMqHVPwdysFUa01w/hImYmbp+WuSZQSyT93NDmnLQBDA
         CMZKnWykUTNrhJ2r5eZ4ggik9FIHuPabhv+pHEMZh78a96LILyoI2Sh8YPU10CbMkVzf
         hnVV1+xUh4In8lGv8Ga1bKB8eZEFkGRCsqMdwgfo0S/1uR+1SlgtGj8NgAn7a5O1cwze
         /6ursv4CwdEPExOdkxq1qg96U67I0eNfE1c6hrx+RJf2ovTf3vsrBoy0wWgeHedetJdi
         KQVtuO/OZR5jWwXM4N+1eNzODtb/0wXxkrNsXRfMQjRSHFs7IKZLDMjpf95mK5y69p98
         l1Sw==
X-Received: by 10.112.146.133 with SMTP id tc5mr20386642lbb.88.1366918248480;
 Thu, 25 Apr 2013 12:30:48 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 12:30:48 -0700 (PDT)
In-Reply-To: <CALkWK0=Q2KZPioYD21pYLzruBnFh_cpFLh_rDj7QDa3bOaCO6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222420>

On Thu, Apr 25, 2013 at 1:25 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> To be in sync with remote-bzr.
>
> Huh?  Why do you have to be in sync with remote-bzr?  Are you sharing
> code between remote-hg and remote-bzr?

We don't have to.

>> @@ -830,7 +831,7 @@ def main(args):
>>
>>      if alias[4:] == url:
>>          is_tmp = True
>> -        alias = util.sha1(alias).hexdigest()
>> +        alias = hashlib.sha1(alias).hexdigest()
>
> Did you eve bother justifying this change with a line in the commit
> message?  How is the new form different from the old form?

Why would it be any difference? It's a hex version of the SHA-1
digest. It would be the same in every language and every tool.

And a bit of context: historically the reason I started remote-bzr was
to show that we didn't need the *huge* infrastructure that is sitting
git_remote_helpers, which is nothing compared to what was prepared to
be merged for msysgit's remote-hg. I wrote it as a proof-of-concept to
show we didn't need a framework, and if we do, it would only be clear
after having _two_ remote helpers, which we now do. It might make
sense to refactor the common parts into a framework later on, so
having them in sync as much as it's reasonably possible makes sense.

But if even if it wasn't, there's nothing wrong with this patch. Also,
who knows, maybe old versions of mercurial don't have util.sha1(), or
maybe newer ones will move it, who knows.

Cheers.

-- 
Felipe Contreras
