From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Wed, 25 Dec 2013 17:31:59 +0100
Message-ID: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <CAM-uYMiLpsQdN41Gs8iJOT-v0qKgod2vEeoC3C+QJ5+wKiVK-Q@mail.gmail.com>
	<1387919476-27921-1-git-send-email-rkagan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Benjamin Pabst <benjamin.pabst85@gmail.com>, git@vger.kernel.org
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Wed Dec 25 17:39:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvrUc-0004hV-0K
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 17:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab3LYQj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 11:39:28 -0500
Received: from static.194.9.251.148.clients.your-server.de ([148.251.9.194]:41968
	"EHLO mail.psioc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab3LYQjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 11:39:14 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2013 11:39:14 EST
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 58E414D6588;
	Wed, 25 Dec 2013 17:32:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Y806RQ7KPsnW; Wed, 25 Dec 2013 17:32:04 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (unknown [213.55.184.149])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 133DF4D64BD;
	Wed, 25 Dec 2013 17:32:02 +0100 (CET)
In-Reply-To: <1387919476-27921-1-git-send-email-rkagan@mail.ru> (Roman Kagan's
	message of "Wed, 25 Dec 2013 01:11:16 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239675>

Roman Kagan <rkagan@mail.ru> writes:

> --- a/perl/Git/SVN/Editor.pm
> +++ b/perl/Git/SVN/Editor.pm
> @@ -304,8 +304,9 @@ sub C {
>  	my ($self, $m, $deletions) = @_;
>  	my ($dir, $file) = split_path($m->{file_b});
>  	my $pbat = $self->ensure_path($dir, $deletions);
> +	my $upa = $self->url_path($m->{file_a});
>  	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
> -				$self->url_path($m->{file_a}), $self->{r});
> +				$upa, $self->{r});
>  	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
>  	$self->chg_file($fbat, $m);
>  	$self->close_file($fbat,undef,$self->{pool});
> @@ -323,8 +324,9 @@ sub R {
>  	my ($self, $m, $deletions) = @_;
>  	my ($dir, $file) = split_path($m->{file_b});
>  	my $pbat = $self->ensure_path($dir, $deletions);
> +	my $upa = $self->url_path($m->{file_a});
>  	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
> -				$self->url_path($m->{file_a}), $self->{r});
> +				$upa, $self->{r});
>  	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $::_q;
>  	$self->apply_autoprops($file, $fbat);
>  	$self->chg_file($fbat, $m);
>
>
> What it does is store the value to be passed to add_file() in a local
> variable, and rely on perl to keep it alive through the end of function
> scope, beyond the call to close_file() where it's actually used.
>
> I'm going to submit a patch adding apr_pstrdup() to subversion folks.
> Meanwhile if people find the above workarond a sensible thing to do in
> git, I can submit a properly formed patch here too.

If you go this way, please add a comment that explains why we need the
local variable.

-- 
Thomas Rast
tr@thomasrast.ch
