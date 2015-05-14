From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 5/5] help.c: output the typical Git workflow
Date: Thu, 14 May 2015 14:59:11 +0200
Message-ID: <1431608351-9413-7-git-send-email-sebastien.guimmara@gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 14 15:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsskZ-0007Na-Tm
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbbENNAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 09:00:21 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35355 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbbENNAS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 09:00:18 -0400
Received: by wgnd10 with SMTP id d10so72245049wgn.2
        for <git@vger.kernel.org>; Thu, 14 May 2015 06:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lLroVQhJ71J6D4MOnlMDvLz+yJepcW68073FilK5/BM=;
        b=fqah7eIbah4NR2P67Oz/CEkQj1ven4L8VJuTKYASDon49ShW8rpeg1AxQC+UyystL+
         kDiyfBzJcOGB6MnE4taAbJN+zlt3UNbC5woK0TZpkIkXAsj+CnimoeSwcaqep/EewlWT
         oYEwiVUx6z9fMrDY/DwT6jQYfM2BA7cXVKZmUghyCDurKa0DmpKRMmF94ONVFiqdTEQo
         eWQOA17eSve6p6pFeUTohqPGIRXiRbWHrbolVbQZMIl8tsf107+nX7lAl/4uOrRZ8p09
         IpO+7NbHBGL7by65H3DTx70SZGow9R7MvSIimPHocgSjDZYp1jXnz3Y9NG4STPCMYOu2
         SZyw==
X-Received: by 10.180.94.168 with SMTP id dd8mr8970540wib.76.1431608416835;
        Thu, 14 May 2015 06:00:16 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id pj5sm32671676wjb.40.2015.05.14.06.00.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 06:00:16 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269036>

=46rom: Eric Sunshine <sunshine <at> sunshineco.com>
Subject: Re: [PATCH v5 0/6] git help: group common commands by theme
Newsgroups: gmane.comp.version-control.git
Date: 2015-05-11 05:52:50 GMT (1 day, 12 hours and 19 minutes ago)

On Sat, May 9, 2015 at 1:17 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara <at> gmail.com> wrote:
> S=C3=A9bastien Guimmara (6):
>   generate-cmdlist: parse common group commands
>   help.c: output the typical Git workflow
>   command-list.txt: group common commands by theme
>   Makefile: update to new command-list.txt format
>   new-command.txt: mention the common command groups
>   cmd-list.perl: ignore all lines until [commands]

When preparing a patch series, it's important to think not just about
the final result but also the state of the project at any point within
the series. The project should remain in a working state (not broken
and not regressed) at all steps during the patch series[1]. As each
patch is applied, you should be able to build git successfully, and
run "git help" and get expected results (for that point in the
series). If you can't do either, then there is a problem.

Unfortunately, the organization of this series (v5) breaks the build
and raw functionality from the get-go. Here is a proposed organization
which will keep the project in a sane state as each patch is applied:

patch 1:

[x] Add a [commands] header to command-list.txt
[x] check-docs in Makefile, and either
[x] cmd-list.perl to ignore everything up to and including [commands].=20

You're not actually doing any classification in
command-list.txt at this point, but instead merely preparing the
machinery to deal with the [commands] header (and the [common] section
which you will add in a subsequent patch).

patch 2:

[x] Add the [common] block to command-list.txt and tag each of
the common commands with an attribute from [common]. Do *not*,
however, remove the old "common" tag at this point since
generate-cmdlist.sh still needs it.

patch 3:=20
[x] Introduce generate-cmdlist.awk and=20
[x] retire generate-cmdlist.sh,=20
[x] along with the associated Makefile changes. This
patch should be exactly the one I posted[2] (between the "--- >8 ---"
lines), along with the minor fixup[3]. The changes in that patch are a
logical unit, so they shouldn't be split up (as you did in v5 between
patches 1/6 and 4/6).

patch 4:=20
[x] Drop the old "common" attribute from command-list.txt items
since it's no longer needed by any machinery.

patch 5: Update help.c to group and sort the commands using the new
common_cmd_groups[] array and common_commands[].group field.

patch 6 [optional]: Update howto/new-command.txt. Alternately, and
probably preferably, fold this documentation update into patch 2 and
omit this step.

[1]: This is called "preserving bisectability". See "git bisect".
[2]: http://article.gmane.org/gmane.comp.version-control.git/268598
[3]: http://article.gmane.org/gmane.comp.version-control.git/268599
