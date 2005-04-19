From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: SCSI trees, merges and git status
Date: Mon, 18 Apr 2005 19:13:14 -0500
Message-ID: <1113869594.4998.103.camel@mulgrave>
References: <1113856118.4998.70.camel@mulgrave>
	 <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org>
	 <1113866092.4998.92.camel@mulgrave>
	 <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 02:09:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgJA-0002DT-A1
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDSANi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVDSANi
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:13:38 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:18305 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261202AbVDSANX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 20:13:23 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id j3J0DFA23336;
	Mon, 18 Apr 2005 20:13:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504181651241.15725@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 17:03 -0700, Linus Torvalds wrote:
> The patches from you I have in my tree are:
> 
> 	scsi: add DID_REQUEUE to the error handling
> 	zfcp: add point-2-point support
> 	[PATCH] Convert i2o to compat_ioctl
> 	[PATCH] kill old EH constants
> 	[PATCH] scsi: remove meaningless scsi_cmnd->serial_number_at_timeout field
> 	[PATCH] scsi: remove unused scsi_cmnd->internal_timeout field
> 	[PATCH] remove outdated print_* functions
> 	[PATCH] consolidate timeout defintions in scsi.h

Those are a subset of patches from my scsi-misc-2.6 tree .. that's the
problem.  The actual patches should be:

  o zfcp: convert to compat_ioctl
  o sg.c: update
  o updates for CFQ oops fix
  o finally fix 53c700 to use the generic iomem infrastructure
  o fix NMI lockup with CFQ scheduler

I've redone the scsi-rc-fixes-2.6 tree to remove all the contamination
and reset the head correctly.

I've verified that if I strip your tree back to 

54ff646c589dcc35182d01c5b557806759301aa3

and then do a 

git-pull-script rsync://www.parisc-linux.org/~jejb/scsi-rc-fixes-2.6.git

Then the git-pull... script actually does the merge and the resulting
tree checks out against BK

Sorry for the screw up.

James


> or at least that's what they claim in their changelogs.
> 
> Oh, and here's the diffstat that matches "scsi":
> 
>  drivers/block/scsi_ioctl.c                 |    5 -
>  drivers/s390/scsi/zfcp_aux.c               |    4 -
>  drivers/s390/scsi/zfcp_def.h               |    5 +
>  drivers/s390/scsi/zfcp_erp.c               |   20 +++++
>  drivers/s390/scsi/zfcp_fsf.c               |   38 ++++++++--
>  drivers/s390/scsi/zfcp_fsf.h               |    6 +
>  drivers/s390/scsi/zfcp_sysfs_adapter.c     |    6 +
>  drivers/scsi/53c7xx.c                      |   23 +++---
>  drivers/scsi/BusLogic.c                    |    7 -
>  drivers/scsi/NCR5380.c                     |    9 +-
>  drivers/scsi/advansys.c                    |    7 -
>  drivers/scsi/aha152x.c                     |   17 ++--
>  drivers/scsi/arm/acornscsi.c               |    9 +-
>  drivers/scsi/arm/fas216.c                  |    9 +-
>  drivers/scsi/arm/scsi.h                    |    2 
>  drivers/scsi/atari_NCR5380.c               |    9 +-
>  drivers/scsi/constants.c                   |    2 
>  drivers/scsi/ips.c                         |    7 -
>  drivers/scsi/ncr53c8xx.c                   |   14 ---
>  drivers/scsi/pci2000.c                     |    4 -
>  drivers/scsi/qla2xxx/qla_dbg.c             |    6 -
>  drivers/scsi/scsi.c                        |    5 -
>  drivers/scsi/scsi.h                        |   43 -----------
>  drivers/scsi/scsi_error.c                  |   11 ---
>  drivers/scsi/scsi_ioctl.c                  |    5 -
>  drivers/scsi/scsi_lib.c                    |    2 
>  drivers/scsi/scsi_obsolete.h               |  106 -----------------------------
>  drivers/scsi/scsi_priv.h                   |    5 -
>  drivers/scsi/seagate.c                     |    5 -
>  drivers/scsi/sg.c                          |    3 
>  drivers/scsi/sun3_NCR5380.c                |    9 +-
>  drivers/scsi/sym53c8xx_2/sym_glue.c        |    6 -
>  drivers/scsi/ultrastor.c                   |    4 -
> 
> so it doesn't look like there's a _lot_ wrong. Send in a patch to revert 
> anything that needs reverting..
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

