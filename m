From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 23:29:38 +0200
Message-ID: <201004142329.38914.jnareb@gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <201004142212.33162.jnareb@gmail.com> <7vbpdlpy5t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:29:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2A9A-0004II-CL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab0DNV3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 17:29:17 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:39336 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756012Ab0DNV3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 17:29:07 -0400
Received: by bwz1 with SMTP id 1so997398bwz.2
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lCn8ayI3d+zGC+oFIMAR4HBJifxNTECstaqmds7uN90=;
        b=ebvXRHtQ89PA9p5a8UAhaAf/M/5shPhh2kR6fFJbPvObmrjuHZci6KW0/5b/cOUuFw
         ZqL4cEIXl5gA0oAZUrfQM+3UFstWBA0QhEqUBy4+GctiYKcftuD5tZJMMWzNkEqVZ3u6
         qxal2hrgZc2uZi+srHInT7nYATnMlgKQoqMKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oE2s0FKV2TLudUlIHTURuv0Q5/29QuoqckoNn2jVtfWPQzxlfnBpPl65YOFc9ksPuS
         VyQZVGe6XHFh21D8xPBTSzip4UnKdXx6cOw1sUVqWhzf300/bmEzH6zjI6vCbNQHTJrj
         2l5Gtn6ghxlDTFD2WqlgR3agsG/AiKVgEk0QE=
Received: by 10.204.131.153 with SMTP id x25mr494745bks.159.1271280544770;
        Wed, 14 Apr 2010 14:29:04 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 14sm738389bwz.10.2010.04.14.14.29.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 14:29:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vbpdlpy5t.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144919>

On Wed, 14 April 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> Wouldn't the exact same argument apply equally well to the output format
>>> of "status --porcelain", by the way?  It is line-based and pretty much
>>> self-describing (once you know the mnemonic but you can make an educated
>>> guess from previous SCM experience).
>>
>> No, current "git status --porcelain" output is record-based (tabular);
>> the meaning is not described by header but depends on field in record,
>> i.e. position in line.
> 
> Now, what's wrong about that?

Well, this whole idea started with the fact, that "git status --short"
was hard (or impossible) to parse unambigously by scripts[1], and even
"git status --porcelain -z"[2] is not that easy to parse[3].

With JSON output format one can use existing JSON parsers, which are
available in any language.

[1] And it was woefully underdocumented
[2] I wonder why git-config and git-grep have '--null' as long version
    of '-z' option... and only those.
[3] I rather liked the idea of -Z output format, the form that uses
    NUL as field separator for each field (and not only filenames),
    and NUL NUL as record terminator; it makes parsing much easier
    because you don't need to take a look at other field to know
    where the record ends.

> For that matter, would you say "diff --raw" output should be
> JSON/XMLified because it is columnar? 

It would be nice to have raw diff format JSONified, or have --porcelain
(like "git blame --porcelain" output format) version of it.  Especially
for "diff -c --raw" i.e. raw output format for merges, which lacks some
information, namely filename and similarity score for n-th pre-image,
if rename or copy was detected.

-- 
Jakub Narebski
Poland
