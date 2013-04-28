From: Yann Hodique <yann.hodique@gmail.com>
Subject: consistency problem on ZFS
Date: Sun, 28 Apr 2013 20:11:25 +0100
Message-ID: <m2bo8yxyg2.fsf@jarvis.hodique.info>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 28 21:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWX1F-0002Ni-3C
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 21:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450Ab3D1TMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 15:12:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:35557 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756416Ab3D1TML (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 15:12:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UWX17-0002Hh-B4
	for git@vger.kernel.org; Sun, 28 Apr 2013 21:12:09 +0200
Received: from cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com ([86.27.183.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 21:12:09 +0200
Received: from yann.hodique by cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 21:12:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpc25-cmbg15-2-0-cust4.5-4.cable.virginmedia.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (darwin)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAACpQTFRF
 HBgXPyYdPSkeMiwmRkJBYT4sik8zZF1XqWpMx2RDk42MzYRYtrGw09DVySZyaAAAAklJREFUOMuF
 0z9v00AUAPCHr/kANgowOi6hjFbOCImp1CdF6kaUCwEmkBJSdYmUSBZRGRMsske1MlKIFKVr5XAr
 U1TPSFX6XXjvnKp2KOLG97v3x3dnuP7Hgv/B+vLyLlivZkGwSP6GlXABvHmyDese0GIn2zBzNYCX
 bEGagOswycG6ewMsyMEVVTJMiyQHv2lzuTOSNrDPWfhF8FSpuGXt5IB6s6bCNfLOt8FoEMT1JAv7
 wFz25E7gtqFLqS856IJhl481/MyN27tnGe+wc1uprzn4fvS+MFYxwvDtLcyT1Y9oUhyri3ZHtTIg
 B7NP0WmDMo7VcJABKRvRtKNbq3hxC21ZKx2pMAWVgQt5H95MNSynKnMfZTzTQkSwjKLpPAN1H+CB
 zogmYaa5ED7eUzMeY+tw9HqRAcEBnoUhxYfFQZIBelRNhGjSKj6cb14kBH3hY5dCGI+XpzXTebzJ
 gY+CC47FHiGENQdXVfeBuvA55y5eYRgOnTJRdXC+6eFTiiHbHyplKVGoHGDQw1okzi5BCcUbXANn
 KL4WYAeyZJomJu0l4ALKZvlCvkrBOaG3dhOvdtlLjJt6AP2UN3DosoppOhr20v+Cwq4ncE8JwaLB
 gJpyPa/n0mQIJn0m0EExTHE5HgxUHAvnsjT41ARTnu8juAaUML5bSQHn8vkLBGYDUCkLS+tD577H
 qwjcpl8Le+BmIWgnHkrgws5BCvjTMbpaAsHPcK6+jXNhLfqGQND4XHhn4Ik5T8HCzKu+Bk98qwq+
 6AFOimPZ8Aem5xXrk2gG/wAAAABJRU5ErkJggg==
Cancel-Lock: sha1:1jQ+00QYkMsJCZyfi5NNkSsi9wU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222744>

Hi,

I have a weird problem that seems to manifest itself only on ZFS
(actually the Zevo distribution, on OSX). With git 1.8.2.1 by the way.
I just switched to ZFS, so I can't blame that particular version of git.

"Sometimes" (I'd say something like 10-15% of the time, fairly
reproducible anyway), "git diff-files" will see changes that don't exist
for some time, then will catch up with the actual state of the file:

$ git checkout next; git diff-files; git checkout next; git diff-files
Already on 'next'
:100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M	magit.el
Already on 'next'
$

Here it was pretty quick, but sometimes I would see those phantom
diffs for more than 5 seconds.

Interestingly, if I manage to run "git diff" during that time, this one
reports no changes. See https://gist.github.com/sigma/5477827 for a more
complex trace: "git merge" was complaining about changes, yet neither "git
diff" nor "git status" did show any. That's the scenario I tried to
minimize to the invocation above.

I'm willing to accept that the filesystem has some responsibility there,
but the inconsistency bothers me. Anything I can provide to help finding
the root cause of the issue ?

Thanks for any hint (and workarounds are highly welcome, as it breaks
many of my scripts, and magit too :))

Yann.

-- 
A Duke must always take control of his household, for if he does not
rule those closest to him, he cannot hope to govern a planet.

  -- DUKE PAULUS ATREIDES
