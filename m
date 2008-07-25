From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Fri, 25 Jul 2008 23:05:33 +0200
Message-ID: <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
References: <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807231817460.8986@racer> <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer> <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 23:06:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMUUn-0005zY-18
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbYGYVFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756680AbYGYVFh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:05:37 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:64224 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741AbYGYVFg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:05:36 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 861AE1B1A96;
	Fri, 25 Jul 2008 23:05:34 +0200 (CEST)
In-Reply-To: <20080725140142.GB2925@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90115>

On 25. juli. 2008, at 16.01, Dmitry Potapov wrote:

> On Fri, Jul 25, 2008 at 02:30:16PM +0200, Eyvind Bernhardsen wrote:
>>
>> Fair enough.  Did you read the rest of my email to see when I think
>> Git should mess with content?  I've thought about it, and being able
>> to do stuff like this in .gitattributes would work for me:
>>
>> * eol=auto
>> *.bat eol=crlf
>> Makefile eol=lf
>> bin/magic-binary eol=none
>>
>> I.e. "detect line endings and do CRLF->LF conversion on all files
>> except *.bat (*->CRLF), Makefile (*->LF) and bin/magic-binary (do
>> nothing)".
>
> I suppose "* eol=auto" means to convert CRLF->LF on checkin and
> LF->native on checkout?

That's the idea, yes, with "native" being configurable.

> Also, perhaps, it should be also possible to explicitly specify:
> *.txt eol=native
> which is the same as 'auto' but without guessing whether it is text
> or not.

Yes!  Good catch, that needs to be possible.

>> ...but "core.autocrlf" is not versioned and applies to _all_
>> repositories, and anyone who doesn't have the correct setting can  
>> mess
>> the repository up.
>
> I think the real issue here is not as much about being or not being
> versioned, but about forcing and not forcing anything on users.

The reason I want versioning is to fix the problem of enforcing  
normalised line endings in repositories with checked-in CRLFs; I'm not  
sure how to solve it any other way, but I'm open to suggestions.

> If we had core.autocrlf=input as default then clueless users will not
> checkin files with the incorrect ending. But there is an objection to
> that -- you penalize those who always have good endings. And even the
> fact that is merely default value that you can easily change to false
> does not convince everyone.

That is an excellent argument for why setting "autocrlf=true" by  
default on Windows was a bad idea.  Thanks! :)

> The same can be said about your
> * eol=auto
> It forces conversion on everyone, even on those who do not need it.
> Of course, you can say those projects that do not have the problem  
> with
> clueless users putting text files with incorrect end-of-lines will not
> have lines like that in their .gitattribute. Yet, if I participate in
> that project, why do I have to pay the price for this conversion just
> because someone stupid can mess up line-endings?

It's about correctness: if the repository isn't supposed to have CRs  
in any text files, that needs to be enforced.  You might not be  
stupid, but that doesn't mean you won't ever take a file that was  
created on Windows and commit it to the repository on Linux.  If the  
tool used to create the file was CR-damaged, there goes the  
repository's LF-only policy.

As you say, the reason I want the setting to be per-repository is that  
I don't think the cost is worthwhile for every repository.  The case  
where it _is_ worthwhile is when the repository will be shared between  
Windows users and Linux users, and the Windows users want CRLFs in  
their working directories.  I think it's worthwhile to actually make  
Git work right in that case.

As a side note, there's a lot of complaining about the cost of  
enforcing LF-only input, but I can't remember seeing any actual  
numbers.  Is it really that bad?

>> There's also no way of saying "this file should
>> have LF line endings, even with autocrlf=true".
>
> Actually, there is
>
> *.sh crlf=input
>
> i.e. I want my shell files to have LF even I normally use CRLF for
> all other files (on Windows).

Won't they still be converted to CRLF on checkout when autocrlf=true  
on Windows?

>> One problem is that the autocrlf setting mixes "I want LF only in my
>> repositories" and "I like to have CRLFs in my working directory" into
>> one config variable.  Instead, I'd like to have a config setting that
>> specifies which line ending form I prefer: "when a text file is  
>> marked
>> eol=auto, convert LFs to CRLFs on checkout".
>
> Following your style above, I believe it should be defined as
> native-eol=crlf

Yes, that sounds right.

> but there are people who do not want to pay any price for conversion.
> Currently, "core.autocrlf=false" means to do nothing about end-of- 
> lines,
> and even to ignore setting in .gitattributes. Should it be possible to
> disable *any* conversion on checkin and checkout? Should this be that
> value be the default, which most users use?

Well, there's no reason why Git repositories used only on Windows  
machines shouldn't store CRLFs, so why should all msysgit users pay  
the cost on every checkin _and_ checkout?

This is the reason the setting needs to be a per-repository policy and  
not a user configuration; users should not be able to configure away  
correctness, but they shouldn't be penalised unnecessarily for it,  
either.
-- 
Eyvind Bernhardsen
