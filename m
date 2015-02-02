From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Mon, 02 Feb 2015 17:48:38 +0100
Organization: gmx
Message-ID: <d5ebe9aeb5f4dd5cbe8673ae2076ba04@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
 <060e1e6a5530dfb311074b0aa854b281@www.dscho.org>
 <54CF70DA.5090506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 02 17:48:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIKB9-0005lq-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 17:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbbBBQsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 11:48:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:50403 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932417AbbBBQsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 11:48:46 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M0bo2-1XNbSL0iH0-00unuD; Mon, 02 Feb 2015 17:48:39
 +0100
In-Reply-To: <54CF70DA.5090506@alum.mit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:lj4JHr4saCIDKECP0VEzrfQffQHZKn0vU6SHBXcJZ5Z3YvVthl8
 CwmYHwMRgl5OPRJ08jLMLby8GYwXAaFhWcnG5DDXBXDphVYWPkEbw6Sf7UobcXJAnH3F/Rz
 lvwcJYd1rT0+McMLgSRy5dJzXStrnK6vRi5CCjbdOtwQcgj8nq0W69YL3bDsz6aH0F1Wztx
 K5TMQUlsS2wiLIHsEUrcg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263261>

Hi Michael,

On 2015-02-02 13:43, Michael Haggerty wrote:
> On 02/02/2015 12:41 PM, Johannes Schindelin wrote:
>> Hi all (in particular Junio),
>>
>> On 2015-01-31 22:04, Johannes Schindelin wrote:
>>
>>> [...] switch to fsck.severity to address Michael's concerns that
>>> letting fsck.(error|warn|ignore)'s comma-separated lists possibly
>>> overriding each other partially;
>>
>> Having participated in the CodingStyle thread, I came to the
>> conclusion that the fsck.severity solution favors syntax over
>> intuitiveness.
>>
>> Therefore, I would like to support the case for
>> `fsck.level.missingAuthor` (note that there is an extra ".level." in
>> contrast to earlier suggestions).
> 
> Why "level"?

"Severity level", or "error level". Maybe ".severity." would be better?

>> The benefits:
>>
>> - it is very, very easy to understand
>>
>> - cumulative settings are intuitively cumulative, i.e. setting
>> `fsck.level.missingAuthor` will leave `fsck.level.invalidEmail`
>> completely unaffected
>>
>> - it is very easy to enquire and set the levels via existing `git
>> config` calls
>>
>> Now, there is one downside, but *only* if we ignore Postel's law.
>>
>> Postel's law ("be lenient in what you accept as input, but strict in
>> your output") would dictate that our message ID parser accept both
>> "missing-author" and "missingAuthor" if we follow the inconsistent
>> practice of using lowercase-dashed keys on the command-line but
>> CamelCased ones in the config.
>>
>> However, earlier Junio made very clear that the parser is required to
>> fail to parse "missing-author" in the config, and to fail to parse
>> "missingAuthor" on the command-line.
>>
>> Therefore, the design I recommend above will require two, minimally
>> different parsers for essentially the same thing.
>>
>> IMHO this is a downside that is by far outweighed by the ease of use
>> of the new feature, therefore I am willing to bear the burden of
>> implementation.
> 
> I again encourage you to consider skipping the implementation of
> command-line options entirely. It's not like users are going to want to
> use different options for different invocations. Let them use
> 
>     git -c fsck.level.missingAuthor=ignore fsck
> 
> if they really want to play around, then
> 
>     git config fsck.level.missingAuthor ignore
> 
> to make it permanent. After that they will never have to worry about
> that option again.

Unfortunately, I have to pass the `receive.fsck.*` settings from `git-receive-pack` to `git-unpack-objects` or `git-index-pack` via the command-line, because it is `git-receive-pack` that consumes the config setting, but it is one of `git-unpack-objects` and `git-index-pack` that has to act on it...

> And Postel needn't be offended :-)

;-)

Ciao,
Dscho
