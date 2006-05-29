From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 12:03:40 -0400
Message-ID: <18609.1148918620@sandelman.ottawa.on.ca>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca>  <20060528220628.GE10488@pasky.or.cz>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 18:04:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkkE7-0004qX-SD
	for gcvg-git@gmane.org; Mon, 29 May 2006 18:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWE2QEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWE2QEQ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 12:04:16 -0400
Received: from cod.sandelman.ca ([192.139.46.139]:20948 "EHLO
	lists.sandelman.ca") by vger.kernel.org with ESMTP id S1751126AbWE2QEQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 12:04:16 -0400
Received: from sandelman.ottawa.on.ca (desk.marajade.sandelman.ca [205.150.200.247])
	by lists.sandelman.ca (8.13.5.20060308/8.11.6) with ESMTP id k4TG3qTS020619
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256 bits) verified OK);
	Mon, 29 May 2006 12:04:01 -0400 (EDT)
Received: from sandelman.ottawa.on.ca (unknown [127.0.0.1])
	by sandelman.ottawa.on.ca (Postfix) with ESMTP id 17CD63AD9E;
	Mon, 29 May 2006 12:03:41 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: Message from Petr Baudis <pasky@ucw.cz> 
   of "Mon, 29 May 2006 00:06:28 +0200." <20060528220628.GE10488@pasky.or.cz> 
X-Mailer: MH-E 7.82; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20951>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>>>>> "Petr" == Petr Baudis <pasky@ucw.cz> writes:
    Petr> The object database is considered "append-only" unless you do
    Petr> git-prune (and you should better not let anyone do that), thus
    Petr> it's enough if you set all directories group-writable. Other

  Exactly, you have to do that. And only the owner can change the modes,
thus, unless all users have their umask set up right, someone gets toasted.
  Since the directories are created on the fly, they need to be created
with the right permissions. 

    Petr> than access the object database, the users probably only want
    Petr> to update the refs - the solution is to make refs/heads/ and
    Petr> refs/tags/ group-writable and setgid. This is also what
    Petr> git-init-db --shared (or tools like cg-admin-setuprepo) should
    Petr> already set up for you.

    Petr> So, what did break?

  Never heard of "git-init-db --shared".

> A shared repository allows users belonging to the same group to push
> into that repository. When specifying `--shared` the config variable
> "core.sharedRepository" is set to 'true' so that directories under
> `$GIT_DIR` are made group writable (and g+sx, since the git group may
> be not the primary group of all users). 

  That would seem to be the right thing.
  Seems it was added in December.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [

    "The Microsoft _Get the Facts CD_ does not work on Linux." - orospakr

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBRHsbW4CLcPvd0N1lAQKa/gf+MF93+zbNnmqpysWMmYPVhW6HvU6XFyCQ
KyTfA7dxVX3tS9coSAcT73IX659umMz1MkyG7YR4ISFLlhLmdthq6l/ETueTZPVw
SgTSEU9TT2sM+gjtzy6v1wGQJAXJxYw6kJgKOFgCfyIPsb7EZWyQBmZLiNU0omnv
gkV8Ja5pJPTNHcinzzNyg8LIm0j55cS9OG9XQrXm46q+9OX+y39BoxGnz3Guzmry
yzfx1ipDuW54QCzKRyBpwt7/1LBfk/eJAH0wP9IAA4qz39+OA2yz8fTMvHDB1a6V
H18SkBENb6ZllGovu60IUgJCKy2sizGkBGUax9ec2ByAzHL1al3W3g==
=arDu
-----END PGP SIGNATURE-----
