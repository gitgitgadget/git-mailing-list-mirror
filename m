From: naderman@naderman.de
Subject: Re: subtree merge tries to merge into wrong directory
Date: Wed, 16 Dec 2009 18:05:04 -0000 (UTC)
Message-ID: <c10155f8a7a2dd451f0b74e323f3a989.squirrel@www.naderman.de>
References: <4B206DCF.90202@naderman.de>
    <32541b130912100638v1f701183w909367cd97c8325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 19:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKyFT-00032q-VL
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 19:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758366AbZLPSFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 13:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756984AbZLPSFM
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 13:05:12 -0500
Received: from naderman.de ([85.119.157.185]:34788 "EHLO naderman.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756934AbZLPSFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 13:05:11 -0500
Received: by naderman.de (Postfix, from userid 65534)
	id DB6E12B4802B; Wed, 16 Dec 2009 18:05:04 +0000 (UTC)
Received: from www.naderman.de (naderman.de [127.0.0.1])
	by naderman.de (Postfix) with ESMTP id 0E5A52B28905;
	Wed, 16 Dec 2009 18:05:04 +0000 (UTC)
Received: from 141.3.89.219
        (SquirrelMail authenticated user naderman)
        by www.naderman.de with HTTP;
        Wed, 16 Dec 2009 18:05:04 -0000 (UTC)
In-Reply-To: <32541b130912100638v1f701183w909367cd97c8325@mail.gmail.com>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
   int  cnt   prob  spamicity histogram
  0.00  107 0.023628 0.021256 ################################################
  0.10    6 0.114140 0.026912 ###
  0.20    0 0.000000 0.026912 
  0.30    0 0.000000 0.026912 
  0.40    0 0.000000 0.026912 
  0.50    0 0.000000 0.026912 
  0.60    0 0.000000 0.026912 
  0.70    0 0.000000 0.026912 
  0.80    0 0.000000 0.026912 
  0.90    7 0.970493 0.197572 ####
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135335>

Avery Pennarun wrote:
> On Wed, Dec 9, 2009 at 10:41 PM, Nils Adermann <naderman@naderman.de>
wrote:
>> Following
>> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
>> I have subtree merged a 3rd party library (ezc-reflection) into my
>> repository (pflow). The prefix I used was lib/ezc/trunk/Reflection. Now
>> there have been changes to ezc-reflection but merging them into my
>> repository fails. The merge is attempted in example/ rather than
>> lib/ezc/trunk/Reflection.
>
> The auto-guessing feature of "merge -s subtree" doesn't always work.
> The 'pu' branch of git has some patches which allow you to use a
> command line like
>
>     git merge -Xsubtree=lib/ezc/trunk/Reflection
>
> If you're nervous about using all of 'pu', try building git's 'master'
> after merging from commit 0354b06927a1220b696a5ee1004a8f061ba9b153.
So I finally got around to trying this. This was my first result:

$ git merge -Xsubtree=lib/ezc/trunk/Reflection/ FETCH_HEAD
fatal: entry  not found in tree 60270661e0d2a5ee03b24609fac5c6d00d048988

Interestingly the following works, as in merges correctly into
lib/ezc/trunk/Reflection/. The "arbitrary" part can be set to anything it
just needs to be set. No directory with that name is created.

$ git merge --strategy-option=subtree=arbitrary FETCH_HEAD
Merge made by recursive.
 .../trunk/Reflection/src/doc_comment_parser.php    |   38
++++++++++---------
 1 files changed, 20 insertions(+), 18 deletions(-)

While the following results in the same issue I originally had with -s
strategy

$ git merge --strategy-option=subtree FETCH_HEAD
CONFLICT (delete/modify): example/src/doc_comment_parser.php deleted in
HEAD and modified in FETCH_HEAD. Version FETCH_HEAD of
example/src/doc_comment_parser.php left in tree.
Automatic merge failed; fix conflicts and then commit the result.

I'm not sure why this is happening, but the
--strategy-option=subtree=arbitrary solves my issue for now.

Cheers
Nils
