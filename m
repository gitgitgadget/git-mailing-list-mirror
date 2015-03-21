From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Sat, 21 Mar 2015 18:35:23 +0100
Organization: gmx
Message-ID: <4388b6e4005c2872aa7f5f83024f021d@www.dscho.org>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
 <vpqwq2eyyzl.fsf@anie.imag.fr>
 <CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 18:35:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZNJ5-00073b-Is
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 18:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbbCURf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 13:35:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:62992 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbCURf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 13:35:26 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LkOeR-1Z6Uvg21Ep-00cPBw; Sat, 21 Mar 2015 18:35:23
 +0100
In-Reply-To: <CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:wYdtw+HN4DeIoIy4EW9xM8QyYbTqhD/oNIkH1A5G6icrTqg5Uv9
 BrF+Criy/sC1D8Yhi7DCgdktZJuBmcPWQGv1r6H1E0zAZnKDljZnOpZlXxOHfhnE8Mf7il4
 OlIWj1BMGCQbXo058uaFDfzvhGJhCJalWZNKspLhwxHMTg+cx+FiMRa8gDUgKRLGzzdxXi5
 l4dgn5h2Jy5OllNrP0avg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266027>

Hi Paul,

On 2015-03-21 14:23, Paul Tan wrote:

> Thanks for the review, though I would like to work on the proposal now
> before the deadline passes :)

That makes sense.

> On Thu, Mar 19, 2015 at 1:52 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Paul Tan <pyokagan@gmail.com> writes:
>>
>>> Ideally, I think the solution is to
>>> improve the test suite and make it as comprehensive as possible, but
>>> writing a comprehensive test suite may be too time consuming.
>>
>> time-consuming, but also very beneficial since the code would end up
>> being better tested. For sure, a rewrite is a good way to break stuff,
>> but anything untested can also be broken by mistake rather easily at any
>> time.
>>
>> I'd suggest doing a bit of manual mutation testing: take your C code,
>> comment-out a few lines of code, see if the tests still pass, and if
>> they do, add a failing test that passes again once you uncomment the
>> code.
> 
> Maybe code coverage tools could help here so we only need to focus on
> the code paths that are untested by the test suite. At the minimum,
> all of the non-trivial code paths in both the shell script and the
> converted builtin must be covered by tests. This should help to
> eliminate most sources of breakages. Anything further than that would
> require an experienced understanding of all the possible important
> inputs to be tested, which I personally feel would make the project
> quite tedious.
> 
> I see git already has gcov support. For shell scripts, maybe kcov[1]
> could be used. With some slight code changes, I managed to generate a
> report for the git-pull tests[2] which should at least provide a good
> starting point for how the tests can be improved.

While it is often a tempting idea to make test suites as thorough as possible, there lies a true danger herein. True war story: in one of the projects I was involved in, the test suite grew to a size that one complete run lasted two weeks. Yes, that is fourteen days. Needless to say: this test suite was run rarely. How useful is a test suite that is run rarely? More useful than a non-existent one, to be sure, but it is still more of a burden than a boon.

Now, on Windows the test suite takes almost three hours to run. This really, really slows down development.

So while we are not yet at the "too large to be useful state", I would caution against trying to get there.

Instead, I would really like to focus on the *usage*. Calling `git grep "git pull" t/` should give you an idea what usage of `git pull` is already tested. It should be pretty easy to come up with a list of *common* use cases, and if any of them are not covered, adding tests for them is simple and straight-forward, too.

Ciao,
Johannes
