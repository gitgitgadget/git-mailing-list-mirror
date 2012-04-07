From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: push.default: current vs upstream
Date: Sat, 07 Apr 2012 09:49:47 +0200
Message-ID: <4F7FF19B.1060407@alum.mit.edu>
References: <7vbonfqezs.fsf@alter.siamese.dyndns.org> <20120329221154.GA1413@sigill.intra.peff.net> <7vfwcqq2dw.fsf@alter.siamese.dyndns.org> <20120330071358.GB30656@sigill.intra.peff.net> <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr> <20120405131301.GB10293@sigill.intra.peff.net> <vpqwr5uceis.fsf@bauges.imag.fr> <20120406071520.GD25301@sigill.intra.peff.net> <vpqr4w12tjj.fsf@bauges.imag.fr> <20120406080004.GA27940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 09:50:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGQPQ-0005jI-S9
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 09:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab2DGHuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 03:50:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33623 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab2DGHuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 03:50:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.140] (p4FC0CBBF.dip.t-dialin.net [79.192.203.191])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q377nlN0024235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 7 Apr 2012 09:49:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120402 Thunderbird/11.0.1
In-Reply-To: <20120406080004.GA27940@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194940>

The very subject of this email is leading the discussion in circles.

Neither current nor upstream is safe for beginners because there are 
distinct workflows that require different behaviors in scenarios that 
git cannot distinguish.

On 04/06/2012 10:00 AM, Jeff King wrote:
> On Fri, Apr 06, 2012 at 09:44:48AM +0200, Matthieu Moy wrote:
> [...]
>> About safety, I don't think we can tell in general which bad push is the
>> most serious. push.default=current may create branches unexpectedly,
>> while push.default=upstream would ask you to "push --set-upstream" when
>> creating the remote branch. push.default=upstream may push to the master
>> when you wanted to create a remote topic branch. My feeling is that both
>> are equally bad, but maybe I'm wrong here.

Exactly.  Choosing between "current vs upstream" is a false dichotomy.

Let's create a new "push.default" option (call it "beginner" for the 
sake of discussion) that is intended for use *only* for people who 
haven't explicitly chosen another alternative.  Let the "beginner" 
option do the obvious thing when it is uncontroversial and undangerous, 
and let it output a beginner-level help message in any scenarios where 
the right thing to do is not obvious.  The help message should basically 
recommend that the user run "git config push.default VALUE" and explain 
the meaning of the possible VALUEs.

If "push.default" is not set, then have it default to "beginner" mode.

> On the other hand, one thing we have not talked about is how one gets
> into the "topic push fast-forwards master" situation. Which is running:
>
>    $ git checkout -b topic origin/master
>
> I'm not sure if that is something totally clueless people will run. And
> maybe by the time people are intermediate enough git users to run that,
> they will have figured out how upstream works. So maybe my concern is
> overblown.

When the "beginner" option is active, this case should trigger the 
informational help message because git cannot know for sure what the 
user wants.

 > I consider the much more likely scenarios for a new user to
> be:
>
>    $ git clone ...&&  cd project
>    $ hack hack hack
>    $ git push
>
> which will work with either "current" or "upstream", or:
>
>    $ git clone ...&&  cd project
>    $ git checkout foo ;# equivalent of "git checkout -b foo origin/foo"
>    $ hack hack hack
>    $ git push
>
> which also works with both

Since the first two scenarios are uncontroversial, the "beginner" option 
should do the expected thing.

 > or:
>
>    $ git clone ...&&  cd project
>    $ git checkout -b topic
>    $ hack hack hack
>    $ git push
>
> which will error out for "upstream", and create a new branch "topic" on
> the remote with "current".

The correct behavior in the above scenario depends on the workflow, so 
the "beginner" option should not do anything except supply help information.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
