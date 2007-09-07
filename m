From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn 1.5.3 does not understand grafts?
Date: Fri, 07 Sep 2007 18:52:14 +0200
Organization: Transmode AB
Message-ID: <1189183934.14841.18.camel@gentoo-jocke.transmode.se>
References: <1189183276.14841.10.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:52:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITh4B-00078k-AR
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 18:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965189AbXIGQwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 12:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757942AbXIGQwR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 12:52:17 -0400
Received: from mail.transmode.se ([83.241.175.147]:4505 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757676AbXIGQwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 12:52:16 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 07 Sep 2007 18:52:14 +0200
In-Reply-To: <1189183276.14841.10.camel@gentoo-jocke.transmode.se>
X-Mailer: Evolution 2.10.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58051>

On Fri, 2007-09-07 at 18:41 +0200, Joakim Tjernlund wrote:
> svnadmin create /usr/local/src/TM/svn-tst/7720-svn/
> svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk -m "Add trunk dir"
> svn mkdir  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp -m "Add swp dir"
> 
> In my git repo I do
> git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
> git-svn fetch
> git branch svn remotes/git-svn
> #make remotes/git-svn parent to the initial commit in my git tree
> graftid=`git-show-ref -s svn`
> echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts
> #da783... is the initial commit in my git tree.
> git-svn dcommit
> 
> fails with:
> Committing to file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp ...
> Commit da783cce390ce013b19f1d308ea6813269c6a6b5
> has no parent commit, and therefore nothing to diff against.
> You should be working from a repository originally created by git-svn
> 
> 
>  Jocke

Using filter-branch helps, but git-svn isn't too happy:

git-svn init  file:///usr/local/src/TM/svn-tst/7720-svn/trunk/swp 
git-svn fetch
git branch svn remotes/git-svn
#make remotes/git-svn parent to the initial commit in my git tree
graftid=`git-show-ref -s svn`
echo da783cce390ce013b19f1d308ea6813269c6a6b5 $graftid > .git/info/grafts
#da783... is the initial commit in my git tree.
git filter-branch $graftid..HEAD
git-svn dcommit

Now I get alot of complaints, but it commits to svn.
It takes forever though:
r3 = 55a489bd4f66dd1f641a4676359d7b8911dc7d83 (git-svn)
W: HEAD and refs/remotes/git-svn differ, using rebase:
:100644 100644 f85ae11af7715a224015582724cb2bab87ec914a
7dc27f2dc58f6dd46cff79d5d762e630febfd419 M    Makefile :100644 100644
4fa08aee7d4cd193cb161115cc079e7c50326e23
0246a89da64f08b0b48f7aa16886bbb2b12df237 M   adc.c :100644 100644
84eba702cce3a9e4f125162f77f3ea52ae45aebc
78347f1f40f7526142bcc5db0708f50dd6150c0a M      adc.h :100644 100644
890dfe7abdac0aa03eeca24572d98e3953db69d7
c2367a52e99af1f036dfc1de442f08cb187a58ab M   bmi.c :100644 100644
92ae3ce7c8c0b3a664dc4ace8ce29b9ac7fd2d9b
40fb9b886e3a51189e662d54cbdbb968e244aa53 M       bmi.h :100644 100644
a21005f15af34cd17e6acd8f1de974e3d82af0f4
ba2c2c4b19bbbfdabae6d3a9980132c4e1e1c07c M      cdrbug.c :100644 100644
5a299761b62ca83fc22d30086b9a082c4de23ee4
3f885b0d8b7c29e7970997ed608df12e23d78644 M   config.c :100644 100644
8a0a8ed90e50d18a9865fa2f5e644ca083a8b783
a2153ef48a59ffdf5a84ca6b93106c98dcb27a9c M control.c :100644 100644
760b828d8e55f6314d313e176578546e3d76b22b
143b44923e1f40d89fa9e87a30dd63abc48cea57 M  database.c :100644 100644
e7cab9865317c1ab4cbe8ecb47b5fda7c0eddcd8
ff519b51ae5428b93504f124ea1f24452b69fa94 M database.h :100644 100644
a28219bc7b5bc692242639fae0e5b54cfaec7bc3
78c8df626c1cf9c989f127f96161850f92cd4588 M defines.h :100644 100644
21e68f9a09a2618493eed4f4c1796293db78c828
68659b3a1bc25a90b103824e089c7c6126f5367b M        eeprom.c :100644
100644 3095638b3f28d5b8e04be1c660fc37bf82e034c2
7ea0835e82aa230f1834b9977ec6a634c400e244 M   eeprom.h :100644 000000
8f7368e29d7ba3dbe34c8e6ad7a3738b68dd1d78
0000000000000000000000000000000000000000 D   fpga.c :100644 000000
2dded257891ada8228f684e9be213b86b6c1fda5
0000000000000000000000000000000000000000 D   fpga.h :100644 100644
97ccea82dd35a7d5973199511d7a9127981f74d3
3758a9334cf04bb670ae2563ad5f2b95af257f3b M     fwrev.h :100644 100644
cd80946581062ead075ba6047d51ae2605e4cc14
2ef670ea229b62bc1b10d087ab2bd3850f08e91a M    glitch.c :100644 100644
d14716ec4351b610dbac81637623a9ca3a8e8902
9e1789933635a5b9e2c562a3c69a973e07b31b7b M   i2cmux.c :100644 100644
6551153cf879ba87d73aa53aa6b768867b026842
4a2813b41231461ab4b316829f9e59ac36498813 M i2cmux.h :100644 100644
2967bc6e21ab9581a47266966867ded04d8076f1
5294b80cbad8d7501fa8c415a0b7b0e1a3343262 M   led.c :100644 100644
9b8016b9c3f13a5fb4446a1f31d1d2311ece32df
2014113eaff9c22f4efd347031d3b7651aa78648 M      led.h :100644 100644
e4d50a5a735105187304f0458cde9102c64aa163
faba2f86b6f86f944ce4995ec5cab2edea0d3bb6 M   lvd.c :100644 100644
aa86ba2a2c313ca688700e75a4353a4d66846b54
bbc2a887b404a06d28ee77c5343278f3a309371f M       main.c :100644 100644
d0f5f5f6538924cfe757e8cdb328f4d7bf9858bd
25e10d528df873425cf32b366c42c01a84367459 M     memmap.c :100644 100644
9bdc8d928ce77ed2f529a0709a3f54a882c37b8b
086b7fc9dd915e43f21e94e963a18184669d361d M   optosfp.c :000000 100644
0000000000000000000000000000000000000000
bb8184467f03194f7aa8cc964a5dfe37603539e3 A        pld.c :000000 100644
0000000000000000000000000000000000000000
405486a29ca8be8212bc307017404ebbed904fe0 A      pld.h :100644 100644
b361784c0b617bdceac5e297e0c3dbb96b2a3dae
869bf82b2e8b710150abf88ca34a9e12378f1415 M      protocol.c :100644
100644 988233f538e9df6c681b2f60a19279567ca2536d
55d9627846575f5f63d907a6dd07979040c64552 M       protocol.h :100644
100644 b43a0c32977e11ad6ccbe9704ce8fdace8914e4d
7872778d025990cdc014d6ca907a3cf9e75050b1 M shell.c :100644 100644
0134ff4ca1a1f8b8d760eb4e367057dbb88b68ed
cda0e129d5fc1390dd7d1e1dd5b9695651c5dcdd M    spi.c :100644 100644
3ea874f32fa1eab87f4d2261a922dc293f379947
24e1be7f8bfe9570464260b6d210cbf7771edaab M      task.c :100644 100644
ca1f966200e5f7126fe0b61a768a5e4b1d49bc94
87a516572095292add8b1b19687a624c38ad205f M   trans.c :100644 100644
b298cc58873100e5e74f53d2a3f62028caba8951
853c18b6c42f9d463f14eede3b84ed700b00dcd5 M    transceiver.cFirst,
rewinding head to replay your work on top of it...
HEAD is now at 55a489b... Initial import of 7700, sws100034.

I get alot similar messages until it is finished.

    Jocke 
