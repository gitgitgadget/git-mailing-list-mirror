From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/8] gitweb: Remove --parents from call to git-rev-list in parse_rev_list
Date: Wed, 06 Sep 2006 23:53:38 +0200
Organization: At home
Message-ID: <edng0d$jng$1@sea.gmane.org>
References: <11575480921132-git-send-email-jnareb@gmail.com> <11575761821830-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Sep 06 23:53:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL5L8-00062q-KX
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 23:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWIFVxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 6 Sep 2006 17:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWIFVxo
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 17:53:44 -0400
Received: from main.gmane.org ([80.91.229.2]:25502 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932193AbWIFVxn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 17:53:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GL5Ks-00060N-13
	for git@vger.kernel.org; Wed, 06 Sep 2006 23:53:30 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 23:53:30 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 23:53:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26567>

Jakub Narebski wrote:

> Benchmarks (7 means patch before, 8 means this patch):
> # 1:gitweb/new~n 2:%e 3:%U 4:%s 5:ab-n10_cgi_time[ms] 6:[+/-sd] 7:ab-=
n10_perl_time[ms] 8:[+/-sd]
> 7 2.59 =A01.53 0 =A02621.073 =A0234.2 =A02742.230 =A0 96.6
> 8 2.89 =A01.80 0 =A03081.722 =A0246.6 =A03306.196 =A0367.2
> 8 2.95 =A01.81 0 =A02952.253 =A0155.9 =A03175.441 =A0128.0

Corrected benchmark (on the same state of repository) are

7 2.67  1.60 0  2694.654  275.2  2866.028  168.4
8 2.84  1.86 0  2892.864  263.0  3135.065   68.1

where the benchmarking commands are
$ /usr/bin/time -f "%e %U %s" \
  GATEWAY_INTERFACE=3D"CGI/1.1" HTTP_ACCEPT=3D"*/*" REQUEST_METHOD=3D"G=
ET" \
  QUERY_STRING=3D"p=3Dgit.git;a=3Dhistory;f=3Dgitweb/gitweb.perl" \
  GITWEB_CONFIG=3D"~/git/gitweb/gitweb_config.perl \
  perl -- ~/git/gitweb/gitweb.perl
$ ab -n 10 "http://localhost/cgi-bin/gitweb/gitweb.cgi?p=3Dgit.git;a=3D=
history;f=3Dgitweb/gitweb.perl"
$ ab -n 10 "http://localhost/perl/gitweb/gitweb.cgi?p=3Dgit.git;a=3Dhis=
tory;f=3Dgitweb/gitweb.perl"

and we get version 7 using
$ git checkout HEAD^ -- gitweb/gitweb.perl
and updating gitweb.cgi in correct place.

So actually removing '--parents' option did make gitweb _slower_ (sic!)=
,
if only slightly.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
