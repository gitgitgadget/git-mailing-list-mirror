From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: one half of a rebase
Date: Sat, 12 Sep 2009 16:38:11 +0200
Message-ID: <4AABB253.2080200@gnu.org>
References: <7f9d599f0909111025q42e3cdc6vba602b84c1d81215@mail.gmail.com> 	<81b0412b0909111410k3f3ebfaco393bb37ff5a6b5c1@mail.gmail.com> <7f9d599f0909111923v76e0f411n16555e7cdc0c3ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Dylan Simon <dylan@dylex.net>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Sat Sep 12 16:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmTk6-0003hr-15
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 16:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbZILOiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 10:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbZILOiN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 10:38:13 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:63132 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZILOiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 10:38:12 -0400
Received: by ewy2 with SMTP id 2so1831548ewy.17
        for <git@vger.kernel.org>; Sat, 12 Sep 2009 07:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=O2qxRkv8savJXsWfaSaWfM2DVGrFKbcqZTFXoMqlXT0=;
        b=nrEQROkRD1bUZY/YE4/B+74OZs89jOn8Yp/UuCeeBHd2xjnBgjNdEn2IT+mZvLLv7p
         x1uwahboWCr4Jjc+ZM90iFxIFvHDqCADMYO2Qmr5Bfa7X1wX1xvcyNkx5fh0CZ6gilX/
         Z5KVimBDk5+uJVxavFBu2fUKaiBPjoX0ldD3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=jV2Xvr7HnoDDwLzduH768LbDFSCCUE2y+1UVp9XnbAuN04OLHt0qoIR2lXxjzbc1X2
         g5Wa1zsC4uCqKo1HTi/l64+ZjsfgncmW8muo0iEn1FLoAUqvunftfTHhxtTqJdNLUnGi
         H5LPZyYH8UgJtCaVN82V9QPstIBEcpMXlSNZ0=
Received: by 10.210.154.9 with SMTP id b9mr965821ebe.34.1252766293653;
        Sat, 12 Sep 2009 07:38:13 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-str.redhat.com [66.187.229.200])
        by mx.google.com with ESMTPS id 23sm5272052eya.41.2009.09.12.07.38.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Sep 2009 07:38:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7f9d599f0909111923v76e0f411n16555e7cdc0c3ed1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128251>

On 09/12/2009 04:23 AM, Geoffrey Irving wrote:
> On Fri, Sep 11, 2009 at 5:10 PM, Alex Riesen<raa.lkml@gmail.com>  wrote:
>> On Fri, Sep 11, 2009 at 19:25, Geoffrey Irving<irving@naml.us>  wrote:
>>> If I could do (2) as a separate operation, it would look something like
>>>
>>>     git cherry-pick-all topic
>>>
>>> which is simpler and faster since it avoids switching files back and
>>> forth (master to topic and back).  Is there a robust way to achieve
>>> the cherry-pick-all semantics with current commands?  If not, how
>>> difficult would it be to partition rebase accordingly?

As mentioned by Alex "git am -3" is basically parsing + the second part 
of rebase.  So, based on Alex's recipe, here is a possible alias for 
cherry-pick-all:

[alias]
	cherry-pick-all = "!f() { git format-patch -k --stdout --full-index 
`git symbolic-ref HEAD`..$1 | git am -k -3 --binary; }; f"

More useful (just because it is more generic) than "the second part of 
git rebase", a "sequencer" would be "the second part of git rebase -i", 
applying a custom script coming from stdin.  If that was present, git 
cherry-pick-all could be done like this:

git log --pretty=tformat:'pick %h' master..topic | git sequencer

And here is yet another alternative, that however would only work only 
if the patches applies perfectly:

git log --pretty=format:%h master..topic | xargs -rn1 git cherry-pick

Paolo
