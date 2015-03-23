From: Shanti Swarup Tunga <b112041@iiit-bh.ac.in>
Subject: about Starter project;implementing log --size in the print_commit function.
Date: Mon, 23 Mar 2015 20:45:11 +0530
Message-ID: <CABJeaiqhL5eNPkaPpheG_Y47Rapj4ys3igHhFH6YuiroECVGDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 16:15:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya44V-0006Kq-0a
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 16:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbbCWPPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 11:15:14 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36613 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbbCWPPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 11:15:13 -0400
Received: by labe2 with SMTP id e2so61337163lab.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 08:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=I6b/jouCx22cBXe9Hh5bUzowySUmvs3nsHkFLg07YyU=;
        b=EOTLWyfMihNRE2NHTqaphS+xpxYL3k+8e3+Xc/GO4RHL9cZQYc0DIYSpndpbSCabAY
         ZN0Nhm46heHgXYmlNEm0rrU1ShsCvbOrg5v7LJhnc8o2KqyVm+NSnArcYBMCJH5hDgMM
         dmyY1oAQRbwvatLovxGRtyV9o7yCyzt6oi4Jto9zZ113Y3BUxgefCSFeFhonhTctqbYX
         P/GEZv6k5Ut5p09singCX4gxk3Yf88N1hTn6i/dQyY4ZrDRMEyUMam0IkzhZ1OLA9KgC
         sjbRcmJ6F2gOLZKxCi5ESUfhWo9dpJlp2lsOrU7mfCI1hnreqT8HC3HGHGP4xop0vt8J
         zBBg==
X-Gm-Message-State: ALoCoQnwV5D1jPIJsSoF3R4PXKBgrya35tmDyti2huUefHEmu0Zxycy434nvii6f5fxigy0eCvjh
X-Received: by 10.152.87.115 with SMTP id w19mr79442996laz.66.1427123711805;
 Mon, 23 Mar 2015 08:15:11 -0700 (PDT)
Received: by 10.112.61.233 with HTTP; Mon, 23 Mar 2015 08:15:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266143>

I inserted a size variable of int type and calculated size in each
cases of print_commit(). The function is

static void print_commit(git_commit *commit)
{
    char buf[GIT_OID_HEXSZ + 1];
    int i, count;
    const git_signature *sig;
    const char *scan, *eol;
    int size=0;

    git_oid_tostr(buf, sizeof(buf), git_commit_id(commit));
    printf("commit %s\n", buf);

    if ((count = (int)git_commit_parentcount(commit)) > 1) {
        printf("Merge:");
        for (i = 0; i < count; ++i) {
            git_oid_tostr(buf, 8, git_commit_parent_id(commit, i));
            size=size+strlen(buf);
            printf(" %s", buf);
        }
        printf("\n");

    }

    if ((sig = git_commit_author(commit)) != NULL) {
        size=size+strlen(sig->name)+strlen(sig->email);
        printf("Author: %s <%s>\n", sig->name, sig->email);
        print_time(&sig->when, "Date:   ");
    }
    printf("\n");

    for (scan = git_commit_message(commit); scan && *scan; ) {
        for (eol = scan; *eol && *eol != '\n'; ++eol) /* find eol */;

        size=size+strlen(scan);
        printf("    %.*s\n", (int)(eol - scan), scan);
        scan = *eol ? eol + 1 : NULL;
    }
    printf("\n");
    printf("%d",size);
}




Will that approach is going to work for the following problem.?
