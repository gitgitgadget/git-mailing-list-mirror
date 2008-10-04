From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse parent..current syntax from pathinfo
Date: Sat, 4 Oct 2008 09:48:14 +0200
Message-ID: <200810040948.15511.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <200810040331.27605.jnareb@gmail.com> <cb7bb73a0810040024q4dfad117uf719f0aaa17ae95b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 09:49:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km1tO-0000XW-S3
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 09:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbYJDHsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 03:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYJDHsY
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 03:48:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:27861 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYJDHsX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 03:48:23 -0400
Received: by nf-out-0910.google.com with SMTP id d3so764787nfc.21
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TBoG5fAdkKyv/xuyqQ+Z8SkZkzhq2HcxB+GPLNbDpPA=;
        b=j8uZt5dyH96n3WieQlU3gPooUFtoCQDvunvsKVtaO+E0nawFOmTDXA1mKT1rgJgBad
         Rfva23fgPcbXUHx/UGRpN/MfoEGPdeUGNHlOZew6cGNfZOjSpKCiEsnvi14gVX9HhPrK
         PqRCcXk6PgX9pvkRmpH9InTgxoMrtHKirhSKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ETeloFR3ZlaTknmmmg7qVy7emxwYPxVGQyj0RWZLlrMfUjAh/X4qaFnqyBx5MvqPRV
         gFaN+j0HZh7wNfQdhD9RUooGK+q6dM5tzk5pPvOpcS84Iyw2i8b/b+riaPbeHvOZa2iS
         DO3EFoNSRn2u5Evbq40srHK7z03sP7YVxkexg=
Received: by 10.210.71.11 with SMTP id t11mr2535577eba.197.1223106501373;
        Sat, 04 Oct 2008 00:48:21 -0700 (PDT)
Received: from ?192.168.1.11? (abwi176.neoplus.adsl.tpnet.pl [83.8.232.176])
        by mx.google.com with ESMTPS id i4sm3268076nfh.1.2008.10.04.00.48.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 00:48:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810040024q4dfad117uf719f0aaa17ae95b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97467>

Giuseppe Bilotta wrote:
> On Sat, Oct 4, 2008 at 3:31 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
>>
>>> This makes it possible to use an URL such as
>>> $project/somebranch..otherbranch:/filename to get a diff between
>>> different version of a file. Paths like
>>> $project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
>>> as well.
>>>
>>
>> In short, it allows to have link to '*diff' views using path_info URL,
>> or in general to pass $hash_[parent_]base and $file_parent using
>> path_info.
> 
> Yes, that's probably a better form for the commit message.

I have thought about this rather as supplement (addition) to the
current commit message (which states explicitly new form of supported
path_info URL), than replacing it.
 
>> The following path_info layouts with '..' make sense:
>>
>>  hpb:fp..hb:f
>>  hpb..hb:f     == hpb:f..hb:f
>>  hp..h
> 
> And these are matched by the above regexp
> 
>> And the layout below can be though to make sense, but it is just
>> plain weird.
>>
>>  hpb:fp..f     == hpb:fp..HEAD:f
> 
> I'm afraid I'm not going to support that, although it's probably easy
> to support hpb:fp..:f (i.e. accept a missing refname but on condition
> of having a : in front of the file spec).

No, not supporting this form is just fine.
 
>>> +             if (defined $input_params{'file_parent'}) {
>>> +                     $input_params{'hash_parent'} ||= git_get_hash_by_path($input_params{'hash_parent_base'}, $input_params{'file_parent'});
>>
>> This line is bit long, and I think it should be wrapped..
> 
> By the way, on the first revision of the path_info patchset, you had me discard
> 
> $hash      ||= git_get_hash_by_path($hash_base, $file_name);
> 
> in the simple case on the basis that it was an extra call to external git.
> 
> I actually forgot to remove it from this part of the patchset too at
> the time, so this gets me wondering about this: should I put it back
> in place in the simple case, or remove it from here too?

I think you should remove it here too.  IMHO if needed, it should be
dealt with (and I think is dealt with) in appropriate action subroutine.

-- 
Jakub Narebski
Poland
