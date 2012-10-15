From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: push race
Date: Mon, 15 Oct 2012 13:50:57 +0200
Message-ID: <CAB9Jk9ABh45TQTu_KKxNGrVzSaT2_ed87M1jO-074ptP4F=w9A@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
	<CAPc5daUon3eLTDT=3wo_=rTCJWVe=ufCvmSzrjD=0T17Dxkpqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <jch2355@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:51:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNjCQ-00042h-PN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab2JOLu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:50:59 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53382 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab2JOLu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:50:59 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so1602339vcb.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZdP+EkyFD9cxB6/RoiBhgVwmEG6ZqNQ2Yfp/nf6XcrU=;
        b=BeVnDVng45qrP/aP+kycc0KyUNFbzwVbtW2CkrYy9tpwfCVPorijBrgNuvrvktSvf8
         lQs4GJ9W0bf3hCbf5vn/PJEYR7e4m75Y+cJrvbbTEm70tYYTtF+1HPQ/GHhhJ45wWefC
         VK2W2jAxwY9ytzcG3jXL2kQKx+qaLVcB7BHLp/ZGVKQb495gE0IukRJDzhLibwWOLpm7
         AmcbIjX9JV/q2YsqfL8DmeAiCq2N+0TuJaxXjGS8hSBcfqWf9kPcZPqLouV7tIq2MgYM
         nOWZ9wzHSffyOsMxI26iWMqwORCfYKxQ84nv+9QEjRr8cUXKaVtLdqgqb951BHL0NK/y
         2Qcw==
Received: by 10.59.8.133 with SMTP id dk5mr6830617ved.19.1350301858384; Mon,
 15 Oct 2012 04:50:58 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Mon, 15 Oct 2012 04:50:57 -0700 (PDT)
In-Reply-To: <CAPc5daUon3eLTDT=3wo_=rTCJWVe=ufCvmSzrjD=0T17Dxkpqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207738>

Hi Junio,

is receive-pack invoked only when using the git or ssh protocols, or is it
invoked also when accessing directly a remote repository as a mounted
filesystem?
But let's see if there are problems also with the other protocols: in
transport.c,
the function git_transport_push calls first get_remote_heads() to get the tips
of the branches and then calls send_pack(). I did not study deeply the code, but
I have the impression that there is nothing that prevents an
interleaved execution
of them by two workstations.
I had a look to receive-pack, and have seen that it creates lock files
for the branches
it updates. However the lock seems to protect only the updating of
files, not the
checking of the tips.

-Angelo
