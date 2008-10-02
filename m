From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Thu, 2 Oct 2008 21:30:42 +0200
Message-ID: <cb7bb73a0810021230u2ec512c0l577b3146cffccb3e@mail.gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <20081002153403.GQ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Oct 02 21:32:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlTtz-0004QE-My
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 21:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbYJBTao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 15:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbYJBTao
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 15:30:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:5170 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbYJBTan (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 15:30:43 -0400
Received: by wr-out-0506.google.com with SMTP id 69so511453wri.5
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 12:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OpMOkrgnUHst3YMFD+4W8mK7HmGftySAZu9NnOeK8aM=;
        b=ly/M/1jWQpm43ycIsTqsmGhAS9WiUAHk6x/ya8IUV2wkhzKau630BCtCqrTazBJjaY
         szltwcD2wboWrc6zxsrej0cmQLpkEAc+TUPBtAQqXUwrN86LRm2Ur8NdWta3cujDxDFp
         0ERaws2/nsEoAR+gX2O4uH+7n0ObHVaY6H/wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=i4FZLt1vNNm0BADP/ujf68E9hElWknnIlV1P6UDfwGiX6b0mlKPfahb/6ZoCkvI3gX
         jHA37meO+25TxnZERrNgwOAcHhrYw7QAYED7WpTSgTYy2UhqOgvhYrv5yFazHMK8Emgw
         oQyV2pIu037V2dp2Q1EzNw/1qLwEl2rdtBdWo=
Received: by 10.150.133.17 with SMTP id g17mr268095ybd.202.1222975842291;
        Thu, 02 Oct 2008 12:30:42 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Thu, 2 Oct 2008 12:30:42 -0700 (PDT)
In-Reply-To: <20081002153403.GQ10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97366>

On Thu, Oct 2, 2008 at 5:34 PM, Petr Baudis <pasky@suse.cz> wrote:

> Just nits...
>> +             $action  = undef;
>
> Extra whitespace.

Right, fixed.

>> +     }
>> +
>>       my ($refname, $pathname) = split(/:/, $path_info, 2);
>>       if (defined $pathname) {
>> -             # we got "project.git/branch:filename" or "project.git/branch:dir/"
>> +             # we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
>>               # we could use git_get_type(branch:pathname), but it needs $git_dir
>>               $pathname =~ s,^/+,,;
>>               if (!$pathname || substr($pathname, -1) eq "/") {
>
> But the old variant is still possible, maybe the comments should
> indicate that the action/ part is optional.

I put the action/ part in square brackets. (e.g.
project.git/[action/]branch:filename). Is this good enough?

>> @@ -534,8 +575,9 @@ sub evaluate_path_info {
>>               $file_name ||= validate_pathname($pathname);
>>       } elsif (defined $refname) {
>>               # we got "project.git/branch"
>> -             $action ||= "shortlog";
>> -             $hash   ||= validate_refname($refname);
>> +             $action    ||= "shortlog";
>> +             $hash      ||= validate_refname($refname);
>> +             $hash_base ||= validate_refname($refname);
>>       }
>>  }
>>  evaluate_path_info();
>
> What is this good for?

The purpose of what? setting both $hash and $hash_base was something
that I found was needed in some extreme cases, as discussed with
Jakub. Proposals for recommended cleaner but equally fast way to
handle it. If you're referring to the whitespace, I was just lining up
the entries. Should I do it in a separate patch?

-- 
Giuseppe "Oblomov" Bilotta
