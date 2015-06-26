From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false
 positives
Date: Fri, 26 Jun 2015 19:13:15 +0200
Organization: gmx
Message-ID: <0838aaf747ce0db5a83de107495270cf@www.dscho.org>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
 <20150626131524.GA2626@peff.net>
 <xmqq381ewiln.fsf@gitster.dls.corp.google.com>
 <20150626162701.GA32123@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	=?UTF-8?Q?Torsten?= =?UTF-8?Q?_B=C3=B6gershausen?= 
	<tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8XC1-0000Wd-PV
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbbFZRN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 13:13:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:55657 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbFZRN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:13:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYLKn-1ZdB9g1Pfd-00V9u6; Fri, 26 Jun 2015 19:13:17
 +0200
In-Reply-To: <20150626162701.GA32123@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:LUma3+7A2DxZPR7GOSRJk6cfGEp+gFi4PXrpBjpCMQgOs/zdRWI
 M9Pmxmash+GsVmXZTJygXHE/EkbMY5vpu7jerHiimlZxqzr3HqbwMYeksRPLJ7J7ccuNeJa
 ADNpdMZwePQxY8kD2I7G1E2BYU7eJsUVIxSu5vSJOlIk94l67Mz0fYufMjJtwuKh5Dg4PMo
 8xKAySJTwZfU6Y820RXtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:STq+uJEzg2w=:MXpQJ3KbH3bGeDf+qZk4at
 PMyiDCOjfwVTJPtnHC66m7ilk9gpxuXBWpFvGuecO1xAO/SxmhVx+gXAb7Bl1nyxnaGfGhliG
 yzSrA5tVE64449OVXrVtyjCDZrXeGg2jhQwDpfYGYyeOtZeC/GuNXZcjVkOrzt8IkVq6JjU4L
 pQ5kZoA12fuTKtrx4pGhKNyBWN+Q8STWwT7IYYoGNLUFadyIS3709PNpWyaJXsZsf3/tPmz57
 ENQOdVpT3GS5Wapk+0+1rj1or1eyeZQWgCNy2+1md+fvqDZ0qIAnzKIu01D1xMVBW9seM2nnN
 imHy6GWbTKlq4L+5c71oX1jK7FqoxP4XTZW8qMQKredCXJZn3NoRygBivz3Q+MeeaDWxyT9No
 Frgyg3MxGj5iJNnw4kC3K9kWFYLL9fOwDbyk/qXsvF6owE7hFNel3E8Lr5BEo08kmpIQt7hKD
 Hwr9AKUOjK5Mv09hrTewUxbI35EdLMoFhKuX1vb7Z/2ZJ4P4oWGSEy6KTGpkicc3iaqrhn1yK
 f57fcV7arnZg0f2YCCkbyenOt7wTQfg01uYu/4HeT9zpj9ZtH71DRflEXMji63LIGMsItlBVK
 RjtEIzXmmoNwyuohPTDY5BQb/cjFE+ywgS7dZy+ypx76Ut7M1An8g2DjW4FxKEGm8K6cIPdlp
 P1WtFx7KpBYu9TPIdGjuQ0MNH+Rc4ALK2VKyfvq/z9tcRx8uaUFztB38d5KO8KG3a5V4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272800>

Hi Peff,

On 2015-06-26 18:27, Jeff King wrote:
> On Fri, Jun 26, 2015 at 09:16:20AM -0700, Junio C Hamano wrote:
> 
>> > FYI, this ended up biting me today. We have some integration tests that
>> > make sure we can clone over putty, and we wrap plink in a
>> > "plink-wrapper.sh" script that tweaks a few extra options. That used to
>> > match under the old scheme, but not the new. It would also match if we
>> > looked for "plink" anywhere in the basename (but not in leading
>> > directories).
>>
>> So this was a minor regression? ;-)
> 
> Yes. :)
> 
>> > I was able to work around it pretty easily by changing our test setup,
>> > but I thought I would include it here as a data point. It's probably not
>> > that representative of real-world users.
>>
>> I'd imagine that "/usr/local/github/wrapped/bin/plink" may be a more
>> appropriate name to install that wrapper as than "plink-wrapper.sh",
>> but then people would need to think how to help that wrapper find
>> the real plink, so...
> 
> It's the test suite for the server side of our git infrastructure, so
> nothing gets installed. It's more like:
> 
>   export GIT_SSH=$PROJECT_ROOT/test/plink-wrapper.sh
>   export REAL_PLINK=$PROJECT_ROOT/vendor/putty/plink
>   git clone localhost:foo.git
> 
> and the wrapper knows to chain to $REAL_PLINK. So it was actually pretty
> easy to swap, without any hacks to avoid recursing to ourselves in the
> $PATH.
> 
> I doubt it is a problem for most people, because I don't imagine they
> are writing test suites for git-related software.

Sorry to be so unavailable... day-job and Git for Windows[*1*], what can I say.

Would it help you if we detected ^plink[^a-zA-Z]?

Ciao,
Dscho

Footnote *1*: took me friggin' 9 1/2 hours to figure this one out: https://github.com/Alexpux/MSYS2-packages/pull/275
