From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Sat, 01 Mar 2014 04:32:29 -0600
Message-ID: <85vbvyxl8i.fsf@stephe-leake.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
	<87fvn335sm.fsf@fencepost.gnu.org> <858usvz5nj.fsf@stephe-leake.org>
	<87txbj1fnw.fsf@fencepost.gnu.org> <85zjlb1740.fsf@stephe-leake.org>
	<87eh2n16sw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 11:32:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJhDh-0001r2-HP
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 11:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbaCAKce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 05:32:34 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:51591 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750869AbaCAKcd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Mar 2014 05:32:33 -0500
Received: from [70.94.38.149] ([70.94.38.149:50069] helo=TAKVER)
	by cdptpa-oedge03 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 89/6D-02678-F37B1135; Sat, 01 Mar 2014 10:32:32 +0000
In-Reply-To: <87eh2n16sw.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Fri, 28 Feb 2014 18:33:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.142:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243057>

David Kastrup <dak@gnu.org> writes:

> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Stephen Leake <stephen_leake@stephe-leake.org> writes:
>>>
>>>> David Kastrup <dak@gnu.org> writes:
>>>>
>>>>> "do the right thing" commands also tend to do the wrong thing
>>>>> occasionally with potentially disastrous results when they are us=
ed
>>>>> in scripts where the followup actions rely on the actual result.
>>>>
>>>> That is bad, and should not be allowed. On the other hand, I have =
yet
>>>> to see an actual use case of bad behavior in this discussion.
>>>
>>> Huh.
>>>
>>> <http://permalink.gmane.org/gmane.comp.version-control.git/242744>
>>
>> That's about backward incompatibility, which is bad, but not what I =
was
>> talking about above.
>
> No, it isn't.  I quote:
>
>     I sometimes run "git reset" during a merge to only reset the inde=
x
>     and then examine the changes introduced by the merge. With your
>     changes, someone doing so would abort the merge and discard the
>     merge resolution.  I very rarely do this, but even rarely, I
>     wouldn't like Git to start droping data silently for me ;-).
>
> You should not make statements like "I have yet to see an actual use
> case of bad behavior in this discussion" when you actually mean "I=C2=
=A0have
> not yet seen anything I=C2=A0would be interested in doing myself".

Clearly I misunderstood your point. Merely repeating the same statement
that I misunderstood, and adding a misunderstanding of what I said, is
not helpful.

So let me see if I can expand on your use case:

- you do 'git merge', which results in conflicts

- you edit some workspace files to resolve some of those conflicts=20

    (I added this step later, since it was implied but not explicit)

- you do 'git reset', intending 'git reset --mixed' (because that is th=
e
  current default)

    Actually, I can't find a precise definition of 'git reset'. Here is
    the synopsis from the man page for 'git-reset' (from git 1.7.9):

       git reset [-q] [<commit>] [--] <paths>...
       git reset (--patch | -p) [<commit>] [--] [<paths>...]
       git reset (--soft | --mixed | --hard | --merge | --keep) [-q] [<=
commit>]

    In 'git reset', there is no path, so it must be the second or third
    form. But those _require_ one of the -- options. So 'git reset' is
    illegal. Clearly something is wrong here; apparently the third line
    should be:

       git reset [--soft | --mixed | --hard | --merge | --keep] [-q] [<=
commit>]

    with '--mixed' as the default, as is stated later. (perhaps the
    original intent was to not have a default for the third form, but
    that got changed sometime?).

    This command "resets the index" but not the working tree. I'm not
    clear what "reset the index" means here; does it mean "remove all
    entries from the index", or "reset the index to some previous
    state"? In other man pages, "reset" can have either meaning
    depending on context.

- then you "examine changes introduced by the merge". I don't know what
  this means in detail.=20

    Before resetting the index, you could diff a workspace file against
    either HEAD or index. Now you can only diff against HEAD, so I don'=
t
    understand why you wanted to reset the index. That's not relevant t=
o
    this use case; I'll just accept that resetting the index is a usefu=
l
    thing to do here. But I would like to understand why.

- with the "do the right thing" patch, 'git reset' does 'git reset
  --merge' instead

    That "Resets the index and updates the files in the working tree
    that are different between <commit> and HEAD".=20

    "<commit>" in this case defaults to HEAD, so the working tree is
    not changed.

So as I understand it, this does _not_ lose your conflict resolutions.

In fact, it now seems that 'git reset --mixed' is always the same as
'git reset --merge'. So I must be missing something!

--=20
-- Stephe
