From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 20:09:40 +0530
Message-ID: <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<7vehnvvyta.fsf@alter.siamese.dyndns.org>
	<20120729142458.GB16223@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 16:40:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvUff-00033D-Kg
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 16:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab2G2Ojn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 10:39:43 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56176 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab2G2Ojm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 10:39:42 -0400
Received: by lbbgm6 with SMTP id gm6so3086389lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dmdDaybzYPS9R/u4483wagcd35WiTkma8NN0HNFjk5Q=;
        b=nJKhSj2zksoPX+bwh67AUJXkE6pihQ2Yav0GyCE10wApOlGcGmMqT/e4cVmTuCIUMp
         vr677WbWqsgtxGykYBZIFNoW7Td9ky29Zf8m17iZXVo6VgRaPIP3K9zvuTGK4+JNf7sy
         CPQPNxPtL6GrWPxgazAqPNJEpFF3m5VVi+IlUQSNmtyAuwLWcJjbVzm5ekqqI6SgbooF
         O0K/zv6WcnvslEH/s0PWLM+pP6eRhU1oSJ/SLHTjn8/AVwwInzurgmUJ/iYiiQkBytMa
         4fYhf+nucYfHTt4blATE80F9/f8g9tC7TvFC/j+s1tOSRJDoyEL1zXI+ZBTPeDeOC4ew
         mg+Q==
Received: by 10.152.132.40 with SMTP id or8mr8627562lab.24.1343572780841; Sun,
 29 Jul 2012 07:39:40 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 07:39:40 -0700 (PDT)
In-Reply-To: <20120729142458.GB16223@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202480>

On Sun, Jul 29, 2012 at 7:54 PM, Fredrik Gustafsson <iveqy@iveqy.com> w=
rote:
> On Sat, Jul 28, 2012 at 11:58:09PM -0700, Junio C Hamano wrote:
>> Fredrik Gustafsson <iveqy@iveqy.com> writes:
>>
>> > Sometimes the server wants to communicate directly to the git user=
=2E
>> > ...
>> > For example:
>> > gitolite has something called wild repos[1]. The management is
>> > cumbersome and if you misspell when you clone a repo you might ins=
tead
>> > create a new repo.
>> >
>> > This could have been avoided with a simply:
>> > "Do you want to create a new repo[Yn]"
>>
>> I do not think the automatic repository creation done by gitolite is
>> a good use case or example for whatever you seem to be advocating.
>>
>> IIUC, the auto-creation in gitolite-shell::main() is done way before
>> gitolite-shell (which is used as a login shell for incoming ssh
>> sessions) creates a new git repository, goes into it and spawns the
>> git-receive-pack command.  It all happens outside Git.
>>
>>     # auto-create?
>>     if ( repo_missing($repo) and access( $repo, $user, '^C', 'any' )=
 !~ /DENIED/ ) {
>>         require Gitolite::Conf::Store;
>>         Gitolite::Conf::Store->import;
>>         new_wild_repo( $repo, $user, $aa );
>>         gl_log( 'create', $repo, $user, $aa );
>>     }
>>
>> The "access()" we see here is not the Perl builtin access(), but is
>> a function defined in src/lib/Gitolite/Conf/Load.pm; that would be
>> the place to allow the incoming ssh session to talk back to the end
>> user, but at that point there is no Git processing on the server
>> end.
>
> That's a feature. It means that the impact on git would be rather sma=
ll,
> we don't have to involve server-side git at all. The problem so solve=
 is
> how to get client-side git to pass through STDIN and STDOUT (just as =
is
> done with STDERR right now). I see this as a gitolite <-> client-git
> interaction case. No server-git should be involved.

Uggh, no.  Client-git should only talk to server-git.  It shouldn't be
talking first to some *other* program (in this case gitolite), and
then to to server-git.  That doesn't sound sane to me.

You should wrap this whole thing around something else that does it in
3 steps.  Check, create if needed, then the actual git command you
intend to run.  All this should be local to your environment, not
rolled into git; it's far too specific to be rolled into git itself,
if you ask me.

> All the use casese I can imagine will be done before (or after)
> serverside git is executed.
>
>> While I am not fundamentally opposed to adding yet another sideband
>> channel to the git protocol, I do not think adding user interaction
>> at random places in the protocol exchange is a viable or useful
>> approach to implement an enhanced server that works with both
>> enhanced and vanilla clients (and the same is true for enhanced
>> client that works with both enhanced and vanilla server).
>
> Do we mean the same thing with "git protocol"? I specify the protocol=
 as
> everything that happens between the server and the client. Are the
> connection divided into multiple protocoll after eachother? (would it=
 be
> possible to execute git-user-interaction-protocoll first and the
> git-protocoll and then git-user-interaction-protocoll again?).
>
> The vanilla case would be easy to solve if the protocol has git versi=
on
> in its handshake. The STDERR approach is already used and working. A
> vanilla client would have the same functionality as today and en
> enhanced client will have enhanced functionality.
>
> --
> Med v=C3=A4nliga h=C3=A4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Sitaram
