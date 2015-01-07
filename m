From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-gui.sh: support Tcl 8.4
Date: Wed, 07 Jan 2015 08:35:32 +0100
Message-ID: <54ACE1C4.4030502@web.de>
References: <97e448e7908a1f959a7294e389553b5@74d39fa044aa309eaea14b9f57fe79c>	<xmqqvbkjofvw.fsf@gitster.dls.corp.google.com>	<82A625FF-768E-4D7E-8248-B14005464EAE@gmail.com> <xmqqk30zmp9q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 08:36:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8l9n-0004g0-HM
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 08:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbbAGHfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 02:35:51 -0500
Received: from mout.web.de ([212.227.17.12]:51595 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbbAGHfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 02:35:50 -0500
Received: from [192.168.178.41] ([79.211.105.16]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MYw63-1YMhNj0D11-00Vfz7; Wed, 07 Jan 2015 08:35:36
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqk30zmp9q.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:/7yv5SdUB/T3tKFNgvvHIApo9C4g3yGHmZrqg1KBM+f3tX1zJJ0
 i3eROFWL6pPacpa3oVNXiSu+rcBxQRjwlf5VHiTMMp5edXNL4PZvGqH8QhH/ED2sBzWiRpV
 vjNAxu3+BNKCFgbUSoGE/ghq1c1M43M1ITDRioHVLzeDnQdGGpAqxkJU2B6dVdGSIedtm8e
 gloFo2QZSPxlYgBLutvUg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262127>

Am 07.01.2015 um 01:02 schrieb Junio C Hamano:
> ^"Kyle J. McKay" <mackyle@gmail.com> writes:
>> I can't find anything in that thread about why vsatisfies was
>> preferred over vcompare other than the obvious that the vsatisfies
>> version is only a 1-character change.  And that would be more than
>> enough except that Tcl 8.4 doesn't support the trailing '-' vsatisfies
>> syntax.
>
> Yeah, I fully agree with that observation.

Having rather corroded TCL-knowledge myself it was Pat's comment in

    http://thread.gmane.org/gmane.comp.version-control.git/247511/focus=249464

that made me change the patch to use the smaller change of adding
the trailing '-' after vsatisfies instead of using vcompare with
a trailing ">= 0" in v2.

>>> * Would it be a good idea to update the places $gmane/248895 points
>>>    out?  It is clearly outside the scope of this fix, but we may
>>>    want to do so while our mind is on the "how do we check required
>>>    version?" in a separate patch.
>>
>> Makes sense to me, but my Tcl knowledge isn't up to making those
>> changes as the code's a bit different.  I have to paraphrase Chris's
>> message here by saying that I guess those checks are correct if not
>> consistent with the others.

When I looked at it back then I was convinced these checks are ok
and should stay as they are to support ancient Git versions (and
they do not use vsatisfies either).

> OK, let's ask Pat (cc'ed) to apply your version as-is without
> touching these 1.5.3 references.  I do not take patches to git-gui
> directly to my tree.

It's an ack from me on the change below as that was what I came up
with and tested successfully before Pat suggested to just add the '-'.

> -- >8 --
> From: "Kyle J. McKay" <mackyle@gmail.com>
> Date: Tue,  6 Jan 2015 02:41:21 -0800
>
> Tcl 8.5 introduced an extended vsatisfies syntax that is not
> supported by Tcl 8.4.
>
> Since only Tcl 8.4 is required this presents a problem.
>
> The extended syntax was used starting with Git 2.0.0 in commit
> b3f0c5c0 (git-gui: tolerate major version changes when comparing the
> git version, 2014-05-17), so that a major version change would still
> satisfy the condition.
>
> However, what we really want is just a basic version compare, so use
> vcompare instead to restore compatibility with Tcl 8.4.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   git-gui.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index b186329d..a1a23b56 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1283,7 +1283,7 @@ load_config 0
>   apply_config
>
>   # v1.7.0 introduced --show-toplevel to return the canonical work-tree
> -if {[package vsatisfies $_git_version 1.7.0-]} {
> +if {[package vcompare $_git_version 1.7.0] >= 0} {
>   	if { [is_Cygwin] } {
>   		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
>   	} else {
> @@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
>   		close $fd
>   	}
>
> -	if {[package vsatisfies $::_git_version 1.6.3-]} {
> +	if {[package vcompare $::_git_version 1.6.3] >= 0} {
>   		set ls_others [list --exclude-standard]
>   	} else {
>   		set ls_others [list --exclude-per-directory=.gitignore]
>
