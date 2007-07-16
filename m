From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 12:08:03 +0200
Message-ID: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 12:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IANV0-0008CH-2Z
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 12:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760185AbXGPKIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 06:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760261AbXGPKIH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 06:08:07 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39351 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760185AbXGPKIG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 06:08:06 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 8FD463F426; Mon, 16 Jul 2007 12:08:03 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52654>

Hello,
when I call "git clone ~adglth0/work/scripts whatever" as user
everything works as expected. As soon as I call this command as root it
shreds ufs:

        (s092942) [~] git version
        git version 1.5.3.GIT
        (s092942) [~] git clone ~adglth0/work/scripts nonroot
        Initialized empty Git repository in /export/home/adglth0/nonroot/.git/
        remote: Generating pack...
        Done counting 220 objects.
        Deltifying 220 objects...
        2% (5/220) doneIndexing 220 objects...
        100% (220/220) done20) donedonedone
        Total 220 (delta 114), reused 181remote:  (delta 88)
        100% (220/220) done
        Resolving 114 deltas...
        100% (114/114) done
        (s092942) [~] cd nonroot
        ./nonroot
        (s092942) [~/nonroot] git status
        # On branch master
        nothing to commit (working directory clean)
        (s092942) [~/nonroot] fg
        sudo ${SHELL} --rcfile ${HOME}/.bash_profile    (wd: ~)
        (s092942) [~] git clone ~adglth0/work/scripts root
        DO *NOT* RUN GIT AS ROOT clone /export/home/adglth0/work/scripts root
        (s092942) [~] unalias git
        (s092942) [~] git clone ~adglth0/work/scripts root
        Initialized empty Git repository in /export/home/adglth0/root/.git/
        remote: Generating pack...
        remote: Done counting 220 objects.
        Deltifying 220 objects...
        3% (7/220) doneIndexing 220 objects...
        100% (220/220) done20) done0) done
        Total 220 (delta 114), reused 181 (delta 88)
        100% (220/220) done
        Resolving 114 deltas...
        100% (114/114) done
        (s092942) [~] cd root
        (s092942) [~/root] git status
        # On branch master
        # Changed but not updated:
        #   (use "git add/rm <file>..." to update what will be committed)
        #
        #       deleted:    eclogic/acct_per_host.pl
        #       deleted:    eclogic/check_3ware
        #       deleted:    eclogic/check_ipmi.pl
        #       deleted:    eclogic/check_load.pl
        #       deleted:    eclogic/create_nagios_config.pl
        #       deleted:    eclogic/mailrelay/config-2.6.20
        #       deleted:    eclogic/mailrelay/interfaces
        #       deleted:    eclogic/on_all_hosts.pl
        #       deleted:    lifebook/kernel-config
        #       deleted:    s017241/config-2.6.20
        #       deleted:    s017241/firewall
        #       deleted:    s017241/siemens.conf
        #       deleted:    siemens/aliasupdate-tg
        #       deleted:    siemens/check_raid.sh
        #       deleted:    siemens/create_nagios_config.pl
        #       deleted:    siemens/crontab_client
        #       deleted:    siemens/deploy
        #       deleted:    siemens/generate_password.pl.gpg
        #       deleted:    siemens/mail_verrechnung.pl
        #       deleted:    siemens/oracle_beispiel_client.pl
        #       deleted:    siemens/sar_deploy.pl
        #       deleted:    siemens/t3_check_via_telnet.pl
        #       deleted:    thinkpad/config-2.6.20
        #       deleted:    thinkpad/fglrx.patch
        #       deleted:    thinkpad/network-please
        #       deleted:    thinkpad/xorg/build
        #       deleted:    webfarm/config-2.6.20
        #
        no changes added to commit (use "git add" and/or "git commit -a")
        (s092942) [~/root] git checkout -f HEAD
        (s092942) [~/root] git status
        # On branch master
        # Changed but not updated:
        #   (use "git add/rm <file>..." to update what will be committed)
        #
        #       deleted:    eclogic/acct_per_host.pl
        #       deleted:    eclogic/check_3ware
        #       deleted:    eclogic/check_ipmi.pl
        #       deleted:    eclogic/check_load.pl
        #       deleted:    eclogic/create_nagios_config.pl
        #       deleted:    eclogic/mailrelay/config-2.6.20
        #       deleted:    eclogic/mailrelay/interfaces
        #       deleted:    eclogic/sms.pl
        #       deleted:    lifebook/network-please
        #       deleted:    s017241/config-2.6.20
        #       deleted:    s017241/firewall
        #       deleted:    s017241/xorg.conf
        #       deleted:    siemens/aliasupdate-tg
        #       deleted:    siemens/check_raid.sh
        #       deleted:    siemens/create_nagios_config.pl
        #       deleted:    siemens/crontab_client
        #       deleted:    siemens/deploy
        #       deleted:    siemens/generate_password.pl.gpg
        #       deleted:    siemens/mail_verrechnung.pl
        #       deleted:    siemens/oracle_beispiel_client.pl
        #       deleted:    siemens/sar_deploy.pl
        #       deleted:    siemens/tryserver.sh
        #       deleted:    thinkpad/config-2.6.20
        #       deleted:    thinkpad/fglrx.patch
        #       deleted:    thinkpad/network-please
        #       deleted:    thinkpad/xorg/cleanup
        #       deleted:    webfarm/unsplit.pl
        #
        no changes added to commit (use "git add" and/or "git commit -a")
        (s092942) [~/root] ls
        eclogic/   leo*       lifebook/  s017241/   siemens/   thinkpad/  webfarm/
        (s092942) [~/root] ls siemens/
        t3_check_via_telnet.pl*
        (s092942) [~/root] cd ..
        (s092942) [~] rm -rf root/
        rm: Unable to remove directory root/: File exists
        (s092942) [~] find root/
        root/
        (s092942) [~] ls -al root/
        total 6
        drwxr-xr-x  56 root     root         512 Jul 16 11:48 ./
        drwxr-xr-x  17 adglth0  root        1536 Jul 16 11:48 ../
        (s092942) [~] df -h .
        Filesystem             size   used  avail capacity  Mounted on
        /dev/dsk/c0t0d0s7       75G   9.0G    65G    13%    /export/home
        (s092942) [~] ls -ali root/
        total 6
        13657 drwxr-xr-x  56 root     root         512 Jul 16 11:48 ./
        5829 drwxr-xr-x  17 adglth0  root        1536 Jul 16 11:48 ../
        (s092942) [~] gfind /export/home -xdev -inum 13657
        /export/home/adglth0/root
        (s092942) [~]

A few notes and observations I did. Linux _does_ not allow userland to
create hardlinks for directories which makes totally sense. Solaris does
allow the _root_ user to allow hardlinks for directories. There is even
a command that makes that possible:

        (faui04a) [/var/tmp] mkdir test
        (faui04a) [/var/tmp] /usr/xpg4/bin/link test bla
        (faui04a) [/var/tmp] ls -ali
        total 13
        1639 drwxrwxrwt    4 root     sys          9216 Jul 16 11:13 ./
        4 drwxr-xr-x   48 root     sys          1024 Jan  1  2007 ../
        238939 drwx--x--x    3 snalwuer icipguru      512 Jul  5 19:08 1071895580/
        238945 drwxr-xr-x    3 root     root          512 Jul 16 11:11 bla/
        238945 drwxr-xr-x    3 root     root          512 Jul 16 11:11 test/
        (faui04a) [/var/tmp] find . -inum 238945

Whatever. My first impression was that the filesystem of the solaris is
broken. So I fscked it. And guess what it corrected the error. But after
the reboot I tried it again and you see the result above. So my guess is
that git calls the link system call in a way Solaris thinks it should
itself shoot in the head. This also happens with _remote_ clones as
root:

        (s092942) [~] git clone adglth0@157.163.208.106:/home/adglth0/work/scripts second_test_as_root
        Initialized empty Git repository in /export/home/adglth0/second_test_as_root/.git/
        The authenticity of host '157.163.208.106 (157.163.208.106)' can't be established.
        RSA key fingerprint is 72:27:be:82:f7:71:e5:23:a6:b6:57:a9:11:dd:26:26.
        Are you sure you want to continue connecting (yes/no)? yes
        Warning: Permanently added '157.163.208.106' (RSA) to the list of known hosts.
        remote: Generating pack...
        remote: Done counting 220 objects.
        remote: Deltifying 220 objects...
        remote:  100% (220/220) done
        Indexing 220 objects...
        remote: Total 220 (delta 115), reused 37 (delta 9)
        100% (220/220) done
        Resolving 115 deltas...
        100% (115/115) done
        (s092942) [~] cd second_test_as_root/
        ./second_test_as_root/
        (s092942) [~/second_test_as_root] git status
        # On branch master
        # Changed but not updated:
        #   (use "git add/rm <file>..." to update what will be committed)
        #
        #       deleted:    eclogic/acct_per_host.pl
        #       deleted:    eclogic/check_3ware
        #       deleted:    eclogic/check_ipmi.pl
        #       deleted:    eclogic/check_load.pl
        #       deleted:    eclogic/create_nagios_config.pl
        #       deleted:    eclogic/mailrelay/config-2.6.20
        #       deleted:    eclogic/mailrelay/interfaces
        #       deleted:    eclogic/on_all_hosts.pl
        #       deleted:    lifebook/kernel-config
        #       deleted:    s017241/config-2.6.20
        #       deleted:    s017241/firewall
        #       deleted:    s017241/siemens.conf
        #       deleted:    siemens/aliasupdate-tg
        #       deleted:    siemens/check_raid.sh
        #       deleted:    siemens/create_nagios_config.pl
        #       deleted:    siemens/crontab_client
        #       deleted:    siemens/deploy
        #       deleted:    siemens/generate_password.pl.gpg
        #       deleted:    siemens/mail_verrechnung.pl
        #       deleted:    siemens/oracle_beispiel_client.pl
        #       deleted:    siemens/sar_deploy.pl
        #       deleted:    siemens/t3_check_via_telnet.pl
        #       deleted:    thinkpad/config-2.6.20
        #       deleted:    thinkpad/fglrx.patch
        #       deleted:    thinkpad/network-please
        #       deleted:    thinkpad/xorg/build
        #       deleted:    webfarm/config-2.6.20
        #
        no changes added to commit (use "git add" and/or "git commit -a")
        (s092942) [~/second_test_as_root] uname -a
        SunOS s092942 5.10 Generic_118833-17 sun4u sparc SUNW,Sun-Blade-100

So has anyone a idea what is wrong. I have shareded a second machine in
a complete different domain. With a complete different git version. Same
thing. So it is not the hardware and not the specific git version and
not the Solaris version:

        (faui04a) [/var/tmp] git clone ~sithglan/work/sc
        screen/                       scripts/                      scripts_ccbank_what_the_hell/
        (faui04a) [/var/tmp] git clone ~sithglan/work/repositories/
        private/ public/
        (faui04a) [/var/tmp] git clone ~sithglan/work/repositories/public/
        blastwave.git/ bs.git/        easix.git/     mutt.git/      nzb.git/       ra.git/        watchdog.git/
        (faui04a) [/var/tmp] git clone ~sithglan/work/repositories/public/easix.git/
        DO *NOT* RUN GIT AS ROOT clone /home/cip/adm/sithglan/work/repositories/public/easix.git/
        (faui04a) [/var/tmp] unalias git
        (faui04a) [/var/tmp] git clone ~sithglan/work/repositories/public/easix.git/
        Initialized empty Git repository in /var/tmp/easix/.git/
        remote: Generating pack...
        remote: Done counting 317 objects.
        remote: Deltifying 317 objects...
        remote: emote: 317/317) done: ) done17) done
        Indexing 317 objects...
        remote: Total 317 (delta 182), reused 278 (delta 157)
        100% (317/317) done
        Resolving 182 deltas...
        100% (182/182) done

        (faui04a) [/var/tmp] cd easix/
        ./easix/
        (faui04a) [/var/tmp/easix] git status
        # On branch master
        # Changed but not updated:
        #   (use "git add/rm <file>..." to update what will be committed)
        #
        #       deleted:    profiles/icpc
        #       deleted:    profiles/sithglan
        #       deleted:    sources/boot.msg
        #       deleted:    sources/busybox-config
        #       deleted:    sources/config
        #       deleted:    sources/easix.logo.16
        #       deleted:    sources/easixdm
        #       deleted:    sources/f2
        #       deleted:    sources/home-faumachine.tar.gz
        #       deleted:    sources/home-icpc.tar.gz
        #       deleted:    sources/home-simigern.tar.gz
        #       deleted:    sources/home-sithglan.tar.gz
        #       deleted:    sources/home-sitowert.tar.gz
        #       deleted:    sources/linuxrc
        #       deleted:    sources/rc.local
        #
        no changes added to commit (use "git add" and/or "git commit -a")
        (faui04a) [/var/tmp/easix] cd ..
        (faui04a) [/var/tmp] rm -rf easix
        rm: Unable to remove directory easix: File exists
        (faui04a) [/var/tmp] ls -ali easix/
        total 10
        238947 drwxr-xr-x   17 root     root          512 Jul 16 12:01 ./
        1639 drwxrwxrwt    5 root     sys          9216 Jul 16 12:01 ../
        (faui04a) [/var/tmp] git version
        git version 1.5.2
        (faui04a) [/var/tmp] uname -a
        SunOS faui04a 5.10 Generic_118833-24 sun4u sparc SUNW,Sun-Fire-280R


[ I am off the net for 30 mintues ... eating ]

                Thomas
