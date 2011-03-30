From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: Re: [PATCH] submodule: Add --force option for git submodule update
Date: Wed, 30 Mar 2011 22:19:42 +0200
Message-ID: <4D93905E.5030806@morey-chaisemartin.com>
References: <4D92E225.3040602@morey-chaisemartin.com> <4D93773C.2010807@web.de> <4D937B7E.10808@morey-chaisemartin.com> <4D937F09.10000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:19:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51rt-0005AC-Ni
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 22:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861Ab1C3UTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 16:19:48 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:59562 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932792Ab1C3UTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 16:19:47 -0400
Received: (qmail 5255 invoked by uid 503); 30 Mar 2011 20:09:16 -0000
Received: from b9.ovh.net (HELO mail417.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 30 Mar 2011 20:09:16 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Mar 2011 22:19:44 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO uranus.nicolas.morey-chaisemartin.com) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 30 Mar 2011 22:19:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <4D937F09.10000@web.de>
X-Ovh-Tracer-Id: 10403033665830182839
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170422>

On 03/30/2011 09:05 PM, Jens Lehmann wrote:
>> I know it is very intrusive. The main reason for that is I wanted the -f option to always behave the same (meaning throw away changes),
>> whether the submodule is already on the right commit or not.
> 
> Hmm, I don't know if that is a good thing to do. People are used to
> "git submodule update" to only touch those submodule where the HEAD
> differs from the commit recorded in the superproject (And I often
> find myself using "-f" if the command didn't succeed without it).
> But when using "-f" touches other submodules than not using it the
> user might experience a rather unpleasant surprise, I'm not sure we
> want to go that way.
> 

Well I was'nt sure about it either.
The idea for me was to be able to put the repo and submodules in the cloned state (except for ignored files)
In the current version the right thing to do is a bit of a mess:
$ git submodule foreach --recursive 'git checkout -f HEAD'
$ git submodule foreach --recursive 'git clean -f' # An untracked file on HEAD may be overwrittent by the new HEAD so checkout may fail if you don't do that
$ git submodule update --recursive

Hopefully with --force we can simplify to:
$ git submodule foreach --recursive 'git checkout -f HEAD'
$ git submodule update --recursive --force

However the first step is not that trivial for most people (I sadly have too many first hand examples with my git users).
If the --force option only works on submodule where HEAD differs from the reference, the first step will still be necessary !
I find this a bit redundant.

Maybe another way would be to add another option.
Keep the --force as you proposed. And add a --all option of some sort that let the user decides if he wants to hit all the submodules or not.
This way we keep the regular behaviour with -f but provide a way to bypass the first step above.

Nicolas Morey-Chaisemartin
