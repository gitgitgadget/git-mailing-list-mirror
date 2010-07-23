From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/5] Fix rebase with file move when diff.renames = copies
Date: Fri, 23 Jul 2010 12:01:03 -0500
Message-ID: <20100723170103.GA2507@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:02:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLdj-0005In-Aq
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760582Ab0GWRCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 13:02:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:63971 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760173Ab0GWRCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:02:06 -0400
Received: by qwh6 with SMTP id 6so3689411qwh.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+QH9TqwhsBTxBuxaL96M2FL8PbF3UhFPzR/iTGA2c8E=;
        b=ZJqcBGEyamRDUZhmEDGlflexsEE5db14g+zuWSvMtJSmONkb1Y+U/di7l4yWzr6aLh
         co3/PF6hebiXqMVKnmFHGIcTqXyS74XJXbErYZgIKWsGuTnfywj2QeIJBTRfJOMmsdZA
         oQbQRs8sS/jmN4YajZsdTV3zIuZsw0zwO+ulM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fI58xMoghXWXRcw+A4Ok55Ge8fE/G1kbZX8qIKdpQFo+/lnvpm84mrt4ierLUpf69v
         4mcHdY71i/jCU7GahNJO0WH3f/5CwJApshDzceaUxHKUwOR6/wHvL6oPQp8Atv4V/jqi
         fyiqR0GAAYeeQlonQ6OMyu6JZpH3qKBClYskM=
Received: by 10.224.48.200 with SMTP id s8mr2869113qaf.168.1279904525555;
        Fri, 23 Jul 2010 10:02:05 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id j28sm460442qck.11.2010.07.23.10.02.03
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 10:02:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <681325.9577.qm@web30002.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151549>

David D. Kilzer wrote:

> My original patch in <http://marc.info/?l=3Dgit&m=3D122635667614099&w=
=3D2> addressed=20
> this in builtin-apply.c, but Junio didn't like this approach as noted=
 in=20
> <http://marc.info/?l=3Dgit&m=3D122636097120953&w=3D2>.

Got it.  This patch just treats the symptoms in my opinion, and if
you read Junio=E2=80=99s message carefully, I think he was also suggest=
ing
that git apply should still be fixed.

Something like this series would fix both.  Please feel free to pick
it up and take it in whatever direction you like.

Hope that helps.

Jonathan Nieder (3):
  t4150 (am): style tweaks
  t4150 (am): futureproof against failing tests
  t3400 (rebase): whitespace cleanup

Junio C Hamano (2):
  Teach "apply --index-info" to handle rename patches
  rebase: protect against diff.renames configuration

 builtin/apply.c   |    3 +-
 git-rebase.sh     |    2 +-
 t/t3400-rebase.sh |  204 ++++++++++++++++++--------------
 t/t4150-am.sh     |  334 +++++++++++++++++++++++++++++++++++----------=
-------
 t/test-lib.sh     |    4 +
 5 files changed, 345 insertions(+), 202 deletions(-)

--=20
1.7.2.rc3
