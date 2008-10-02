From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Thu, 2 Oct 2008 23:05:18 +0200
Message-ID: <cb7bb73a0810021405j68b0a164i9469e64afc543ebf@mail.gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <20081002153403.GQ10360@machine.or.cz>
	 <cb7bb73a0810021230u2ec512c0l577b3146cffccb3e@mail.gmail.com>
	 <20081002205603.GW10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Oct 02 23:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlVNa-0000bM-Nf
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 23:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbYJBVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 17:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754482AbYJBVFW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 17:05:22 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:35506 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbYJBVFV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 17:05:21 -0400
Received: by gxk9 with SMTP id 9so1963882gxk.13
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pDi2yXMPahvsm7/MgNr91frkYG2r4PDAH07RxX8mlc8=;
        b=XQMsIa9u7Lcsqv/C5Xzj5js0mnTJpROFIZvrkmByP98uyZMR+DzhkoA4Lrb1ZKc+4g
         Nvj4E7ueSO9QoZrb1vjN79INQoslqTizj6pl4KwtWkMuHRfE9WunRVWqD/Kd9H1XJMB2
         jeK2VKjhZ68hC2vKp2M9EBD/OQ1jkO6WTDYBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gEfxxGqneKevttfSrAWGjwL7103LjKzqU/X8YlrmpYXClie63gu18pxTbKJ9TsxSb+
         c6JzIhAmXCtmHrKrbIUi7Joy+uAJ6k6VLz5IGH25S3ThjqDTWUbnhiEonALvOt7Ts2r7
         2SY5fEydWmJVxt4inEwFuvPx7iS+eeLTAxd+0=
Received: by 10.151.149.14 with SMTP id b14mr456377ybo.59.1222981519187;
        Thu, 02 Oct 2008 14:05:19 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Thu, 2 Oct 2008 14:05:18 -0700 (PDT)
In-Reply-To: <20081002205603.GW10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97375>

>> >> @@ -534,8 +575,9 @@ sub evaluate_path_info {
>> >>               $file_name ||= validate_pathname($pathname);
>> >>       } elsif (defined $refname) {
>> >>               # we got "project.git/branch"
>> >> -             $action ||= "shortlog";
>> >> -             $hash   ||= validate_refname($refname);
>> >> +             $action    ||= "shortlog";
>> >> +             $hash      ||= validate_refname($refname);
>> >> +             $hash_base ||= validate_refname($refname);
>> >>       }
>> >>  }
>> >>  evaluate_path_info();
>> >
>> > What is this good for?
>>
>> The purpose of what? setting both $hash and $hash_base was something
>> that I found was needed in some extreme cases, as discussed with
>> Jakub. Proposals for recommended cleaner but equally fast way to
>> handle it. If you're referring to the whitespace, I was just lining up
>> the entries. Should I do it in a separate patch?
>
> I refer to the setting of $hash_base (I'm not huge fan of the whitespace
> aligning, but I don't really care). What extreme cases are these?
> I think you should describe that in the code since it's not really
> obvious. Maybe I could find it in older threads but I should understand
> the code just from reading it. :-)

In preparing the new patchset, I've put a big comment block explaining
why we need to set both $hash and $hash_base in this code-path:

# we got "project.git/[action/]branch". in this case
# we set both $hash and $hash_base because different actions
# need one or the other to be set to behave correctly.
#
# For example, if $hash_base is not set then the blob and
# history links on the page project.git/tree/somebranch will
# assume a $hash_base of HEAD instead of the correct
# somebranch.
# Conversely, not setting $hash will make URLs such as
# project.git/shortlog/somebranch display the wrong page.
#
# Since it also turns out that the unused one is properly
# overwritten as needed, setting both is quite safe.


-- 
Giuseppe "Oblomov" Bilotta
