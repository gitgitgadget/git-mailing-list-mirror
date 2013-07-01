From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCH] submodule: add 'exec' option to submodule update
Date: Mon, 01 Jul 2013 21:21:09 +1200
Message-ID: <51D14A05.7030707@gmail.com>
References: <1372413190-32732-1-git-send-email-judge.packham@gmail.com> <20130628104243.GD27497@paksenarrion.iveqy.com> <51CEA4B2.1090008@gmail.com> <51D04F06.9000400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	stefan.naewe@atlas-elektronik.com, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 01 11:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtaHR-00011U-Dd
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 11:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab3GAJUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 05:20:10 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41147 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab3GAJUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 05:20:09 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so4791650pad.16
        for <git@vger.kernel.org>; Mon, 01 Jul 2013 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WPxEztZ2B/ATo+8RoZovHAy4N7yOqTxVp3TwgTxfdak=;
        b=YBH8jote0rU4vcJap0NQVSKOfgs7/fq5d9irRiY+DKlClnBy0SJGDdHeB1QHXkbIZw
         C7c9YU2Z5qT9OB+MhSDUijAlpwHxXnlXRJfkBmIm+2sREb250KyfcLRD8/5qk/dNeRD+
         kn7IpWkb19A1dnQiskSnPxiGnp/sozB9hX21px+O73+2a4AVpK+uhKq3sAJpsTzlfswg
         JH7y8WsndZuPHsZl0PRb6jKbCGlCThfTNw1pm4D73aZv5J54s5y3tfwfOv+ah9qVnpri
         O6/rTP2YEYgjZgaJcu/m9fuWhhNFy1kRHqEtZQf2WZyqeJaFWSDZ9Fix6rucPg16BMOQ
         cp3w==
X-Received: by 10.68.201.66 with SMTP id jy2mr22819424pbc.90.1372670408708;
        Mon, 01 Jul 2013 02:20:08 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id fl2sm22913475pab.23.2013.07.01.02.20.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 01 Jul 2013 02:20:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51D04F06.9000400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229297>

On 01/07/13 03:30, Jens Lehmann wrote:
> Am 29.06.2013 11:11, schrieb Chris Packham:
>> On 28/06/13 22:42, Fredrik Gustafsson wrote:
>>> technically it looks fine to me (except for the lack of tests) but I'm
>>> not sure I follow the use case.
>>>
>>> In your case, you want to run a script to determinate if that certain
>>> submodule should use merge or rebase depending on "whatever". And this
>>> can't be done with git submodule foreach because you want to know the
>>> sha1 to update to. Have I understood you correctly?
>>
>> Correct. We tend to have submodules that are just normal detached heads
>> which we don't usually touch and others that are actively developed
>> where we would use submodule.x.update=rebase (I personally do) but some
>> developers want to use stgit on those repositories.
>>
>> Another approach could be to do a 'git pull --no-recurse-submodule' then
>> use 'git submodule foreach script-that-does-the-rebase'. The benefit of
>> the patch I sent is that it can be setup using the config variables[1]
>> and updated the normal way along with the detached HEADs and those using
>> plain git branches.
> 
> Wouldn't a "stgit submodule update" (which would do the Right Thing for
> submodules initialized with stgit by maybe just using the pull & foreach
> logic you described) be a better UI for solving your problem?

Yeah I guess so. I was hoping to stay away from an stgit specific
solution but I'm not hearing any other voices looking for such flexibility.

>> There may be other use-cases for integration with other tools as well
>> (e.g. something that updates a review tool when commits get rebased).
>>
>> --
>> [1] I'm not crazy about the name of submodule.*.update.command but I
>> couldn't think of a better one.
> 
> Hmm, if we go that route, why not do the same we do for aliases? If
> the submodule.*.update setting is prefixed with a '!', we just execute
> the shell command following. This would give everyone the freedom to
> do arbitrary stuff if the current none, checkout, merge & rebase won't
> do the trick without having to add another config option.
>

Make sense. I'll give it a go.
