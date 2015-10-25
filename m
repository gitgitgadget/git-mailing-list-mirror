From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC] URL rewrite in .gitmodules
Date: Sun, 25 Oct 2015 15:43:35 +0100
Message-ID: <CD8200EC-CE3A-40B7-A595-3B47F47A263B@gmail.com>
References: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com> <CAGZ79kY4A3nbp006JyMCgR_Oe6uHf-ECVD+6fJ-naa=XynUxRQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 15:43:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqMWO-0005Mu-R8
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 15:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbbJYOnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 10:43:39 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33834 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbJYOni convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 10:43:38 -0400
Received: by wikq8 with SMTP id q8so132462399wik.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n6I1+JlnPbtxIFPENWqUHTHx1ooviI4W8GEqqhhu7XY=;
        b=bCBCqdtFG6lkeWuRk/2Q8E0tChmk8Oex+HXgBTdHUl6pFWzsjTI7TiT4NTJ+rtBNVr
         6s9c1cevh1b+tgpy8/lvcVgUK/owDJEVxifSaz0NWWyaNMH/yIzc0Cezv/H/gjXS9ruO
         D74SjHM1Cn9KEzzpYsEM9fmEVIBlC0OMNr5Ii/svCvA+WvneE5avYPerTXT5sk+H0kko
         5JouUYoDJgSnoiOdFO6fXlMh77S2LDXoYE+a3mFGgtA4KWx4YdWkJp5PXZOGqqAh05Qi
         dc8zQnC2jpQ6/ixqbcA1z6YvzBJQi9AGXAPEtA9E64NkkQr20TdkiPjgDJ3KTJsj9G/u
         ryYw==
X-Received: by 10.180.108.129 with SMTP id hk1mr14718483wib.52.1445784217414;
        Sun, 25 Oct 2015 07:43:37 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB6D4C.dip0.t-ipconnect.de. [93.219.109.76])
        by smtp.gmail.com with ESMTPSA id cq8sm9223385wib.12.2015.10.25.07.43.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Oct 2015 07:43:36 -0700 (PDT)
In-Reply-To: <CAGZ79kY4A3nbp006JyMCgR_Oe6uHf-ECVD+6fJ-naa=XynUxRQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280153>


On 20 Oct 2015, at 00:07, Stefan Beller <sbeller@google.com> wrote:

> On Mon, Oct 19, 2015 at 12:28 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>> 
>> I have a closed source Git repo which references an Open Source Git repo as Submodule. The Open Source Git repo references yet another Open Source repo as submodule. In order to avoid failing builds due to external services I mirrored the Open Source repos in my company network. That works great with the first level of Submodules. Unfortunately it does not work with the second level because the first level still references the "outside of company" repos. I know I can rewrite Git URLs with the git config "url.<base>.insteadOf" option. However, git configs are client specific.
> 
> I feel like this is working as intended. You only want to improve your
> one client (say the buildbot) to not goto the open source site, while
> the developer may do want to fetch from external sources ("Hey shiny
> new code!";)
Well, that's a good argument. However, our developers have usually no write access to these repos. If they want to push a commit then they need to fork the open source repo and change the submodule URL in the parent repo. I fear that this kind of process might overwhelm them and/or troubles them (changing Git submodules URLs has a few pitfalls). As a result they might be less inclined to make a contribution or - even worse - they copy the code in the parent repo, don't use Submodules and make no contribution at all. 


> 
>> I would prefer a solution that works without setup on any client. I also know that I could update the .gitmodules file in the Open Source repo on the first level. I also would prefer not to do this as I want to use the very same hashes as defined by the "upstream" Open Source repos.
> 
> You could carry a patch on top of the tip of the first submodule
> re-pointing the nested submodule. This requires good workflows
> available to deal with submodules though. (Fetch and merge or rebase,
> git submodule update should be able to do that?)
True. However, we have many Git beginners and I fear that this workflow would overwhelm them.


>> 
>> Is there yet another way in Git to change URLs of Submodules in the way I want it?
>> 
>> If not, what do you think about a patch that adds a "url" section similar to the one in git config to a .gitmodules file?
>> 
> 
> So we have different kinds of git configs. within one repository, in
> the home director (global to the one machine),
> maybe you would want to have one "global" config on a network share,
> such that every box in your company
> reads that "company-wide" global config and acts upon that?
That could actually work. The only downside I see is that the devs need to intentionally update their "company" git config. We have +4000 engineers and therefore I want to establish processes that are as easy and fault-tolerant as possible.  

> 
>> Example:
>> ----------
>> [submodule "git"]
>>        path = git
>>        url=git://github.com/larsxschneider/git.git
>> 
>> [url "mycompany.com"]
>>        insteadOf = outside.com
> 
> Wouldn't that be better put into say a global git config instead of
> repeating it for every submodule?
See answer above. The git config setup could be an obstacle.

> 
> In case of the nested submodule you would need to carry the last lines
> as an extra patch anyway
> if this was done in the .gitmodules files? Or do you expect this to be
> applied recursively (i.e. nested
> submodules all the way down also substitute outside.com)
Yes, my intention was to apply these recursively.


> Am I missing your point?
I don't think so :-)

Thanks,
Lars