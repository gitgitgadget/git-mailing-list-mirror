From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Fri, 25 Mar 2016 15:58:05 +0100
Message-ID: <20160325155805.Horde.IaS9Rdqv5fu6BmOZCj5ulLW@webmail.informatik.kit.edu>
References: <20160317014310.GA12830@sigill.intra.peff.net>
 <1458386735-8038-1-git-send-email-szeder@ira.uka.de>
 <CAFZEwPNK+XTjXzjn-Pv3iP4XiajXrdhUHWLz-8c0Ssy_Edkd7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 16:13:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajTBt-0001zE-CV
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbcCYO6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 10:58:12 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59112 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752306AbcCYO6L convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:58:11 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ajTBe-0005gK-4g; Fri, 25 Mar 2016 15:58:06 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ajTBd-0001YC-Be; Fri, 25 Mar 2016 15:58:05 +0100
Received: from x590e51bb.dyn.telefonica.de (x590e51bb.dyn.telefonica.de
 [89.14.81.187]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 25 Mar 2016 15:58:05 +0100
In-Reply-To: <CAFZEwPNK+XTjXzjn-Pv3iP4XiajXrdhUHWLz-8c0Ssy_Edkd7A@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1458917886.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289895>


Quoting Pranit Bauva <pranit.bauva@gmail.com>:

> On Sat, Mar 19, 2016 at 4:55 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>>> Yes, I think in general, "-v" and "-q" should work as opposites. Bu=
t
>>> that is not the case with commit, where "-v" and "-q" operate on to=
tally
>>> separate messages. I think that is a UX mistake, and we would not d=
o
>>> it that way if designing from scratch. But we're stuck with it for
>>> historical reasons (I'd probably name "--verbose" as "--show-diff" =
or
>>> something if writing it today).
>>
>> Yeah, as a long-time 'git commit -v' user I never really thought abo=
ut
>> the name of the option, but when I pointed out the multiple verbose
>> levels it struck me as a rather unfortunate name for this feature,
>> too.  Oh, well, we are stuck with it indeed.
>>
>> However, that doesn't mean that we have to spread this badly chosen
>> name from options to config variables, does it?  I think that if we
>> are going to define a new config variable today, then it should be
>> named properly, and it's better not to call it 'commit.verbose', but
>> 'commit.showDiff' or something.  Perhaps we could even define two ne=
w
>> config variables: 'commit.showDiff' for the diff of the changes to b=
e
>> committed (=3D '-v'), and 'commit.showUnstagedDiff' for the - wait f=
or
>> it! - unstaged changes (=3D '-v -v').  Not sure about the variable
>> names, though, because "plain" 'git diff' shows unstaged changes,
>> while 'git diff --cached' shows staged changes.
>
> This seems a better way to go about.
>
>>
>> Furthermore, it doesn't mean that we can't add properly named comman=
d
>> line option(s) and state that '-v|--verbose' is a synonym to
>> '--show-diff' (maybe even deprecate '--verbose'), but I don't want t=
o
>> squeeze even more into a GSOC micro project.
>
> Its perfectly fine. It hardly a half an hour job. Though I like the
> idea that we should use both "-v|--verbose" and "--show-diff" instead
> of deprecating it.

Deprecating doesn't mean "removing".  It merely means that we add a not=
e
to the documentation stating that the option in question is deprecated,
but we will keep supporting it for several years and releases to come.

This means that '--verbose' and '--show-diff' must coexist for quite a
while, and 'git commit' should do the right thing even if both old and
new options are combined.  And, of course, in combination with the new
config variable(s).  I suspect that all this would be more than a half
an hour job.
