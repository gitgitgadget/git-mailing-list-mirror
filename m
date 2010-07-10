From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Cutting history
Date: Sat, 10 Jul 2010 11:58:50 +0000
Message-ID: <AANLkTikY8RKseD8K4RVrLHnSdW_Su8hVRPRFkzzz1rGv@mail.gmail.com>
References: <20100710032553.GB554@nibiru.local>
	<4C37F24E.30407@workspacewhiz.com>
	<m3tyo7lo6n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, weigelt@metux.de,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 13:59:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXYi1-00075F-1C
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 13:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0GJL6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 07:58:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38456 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab0GJL6v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 07:58:51 -0400
Received: by iwn7 with SMTP id 7so3115461iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RBRzo9YBbxPFPDUoAAgA8a3ERJqMwwzUIoOaOiVhFcM=;
        b=HEAPXvpk35KNAFTKSbj0chIbtA0ly6nCF2JIzQpjXuAdQdVa3x98bPiM0GEhlDrgQZ
         nQ9UZNB0UlTYDoQXpHrlOWFmAcdFBLlEeolHk/a8GOcxQlCE/cAHAgYbWFdEq3qipdj7
         Oz8cAztWXgZ7wG5nwtKmDXxxITyDaUJe+60gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jHwhPxYecsMXUtxXzV9p9fh6On91ZwsYi4ZnEOrNqsLzMN6BWg3WkFEaogFqbkPYyw
         Dsu+szb9Z0yEsnBwY/NrLTFBcPnOx8qWHN3DfDkERhSkJm/l4Cna6i4yL5cH2PlJNnyC
         nwTaXtYm0/B2bYyjwIXCdCvQzVuS7cVMcpYzQ=
Received: by 10.231.31.202 with SMTP id z10mr11442547ibc.85.1278763131030; 
	Sat, 10 Jul 2010 04:58:51 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 10 Jul 2010 04:58:50 -0700 (PDT)
In-Reply-To: <m3tyo7lo6n.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150721>

On Sat, Jul 10, 2010 at 08:47, Jakub Narebski <jnareb@gmail.com> wrote:
> Joshua Jensen <jjensen@workspacewhiz.com> writes:
>
>> =C2=A0 ----- Original Message -----
>> From: Enrico Weigelt
>> Date: 7/9/2010 9:25 PM
>>
>> > I'm using git for automatic backups (eg. database dumps). This
>> > works quite well, but as time goes, the history (and so the repo)
>> > gets larger and larger. It would be really nice to allow cutting
>> > off old stuff (eg. after N commits in the past).
>
> This is certainly Using Git For What It Was Not Intended...

It actually works very well though. I use Git to back up MySQL
databases like this.

Here's the script I use to dump MySQL databases:

    http://github.com/avar/linode-etc/blob/master/bin/cron/mysqldump-to=
-git

And a small wrapper to dump them all:

    http://github.com/avar/linode-etc/blob/master/bin/cron/mysqldump-to=
-git-all

I make dumps every 6 hours:

    http://github.com/avar/linode-etc/blob/master/cron.d/v-mysql-git-ba=
ckup

And after each dump I repack & prune (some of this is probably
redundant given the linear history) the repository:

    http://github.com/avar/linode-etc/blob/master/bin/cron/git-repack-a=
nd-gc-dir

And here's graph showing how big the dumps get:

    http://munin.nix.is/nix.is/v.nix.is/dirs_var_backup_mysql.html

The climbing charts before the size cutoff were before I started
repacking them.

As for pruning old history, I thought this *should* work for pruning
history older than 7 days (given that you dump daily):

    git rebase --strategy=3Dbase --onto master~8 master~7

But of course that deletes new commits. I need to freshen up on my
rebase understanding. Maybe someone else on list knows how to do
that. I thought git rebase --interactive might work, but I can't get
it to display the root commit. Maybe you need git-filter-branch.
