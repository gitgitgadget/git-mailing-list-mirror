From: Andrew Morton <akpm@osdl.org>
Subject: git-bisect failed me again
Date: Fri, 12 May 2006 00:02:49 -0700
Message-ID: <20060512000249.71933599.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 12 09:05:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FeRil-0004AV-1U
	for gcvg-git@gmane.org; Fri, 12 May 2006 09:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWELHFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 03:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWELHFr
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 03:05:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751024AbWELHFr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 03:05:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4C75ftH027226
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 May 2006 00:05:42 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k4C75f5p007280;
	Fri, 12 May 2006 00:05:41 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19914>


Trying to find a recently-merged box-killer in Len's tree:

bix:/usr/src/git26> cat .git/branches/git-acpi 
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git#test

git-checkout git-acpi
git-bisect reset
git-bisect start
git-bisect good ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
git-bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9

And it led me to

bix:/usr/src/git26> git-bisect good
9011bff4bdc0fef1f9a782d7415c306ee61826c9 is first bad commit
diff-tree 9011bff4bdc0fef1f9a782d7415c306ee61826c9 (from 7e1f19e50371e1d148226b64c8edc77fec47fa5b)
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 00:28:12 2006 -0400

    ACPI: delete newly added debugging macros in processor_perflib.c
    

which isn't a buggy patch.

bix:/usr/src/git26> cat .git/BISECT_LOG
git-bisect start
# good: [ff2fc3e9e3edb918b6c6b288485c6cb267bc865e] ACPI: EC acpi-ecdt-uid-hack
git-bisect good ff2fc3e9e3edb918b6c6b288485c6cb267bc865e
# bad: [9011bff4bdc0fef1f9a782d7415c306ee61826c9] ACPI: delete newly added debugging macros in processor_perflib.c
git-bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9
# good: [c52851b60cc0aaaf974ff0e49989fb698220447d] P-state software coordination for speedstep-centrino
git-bisect good c52851b60cc0aaaf974ff0e49989fb698220447d
# good: [7e1f19e50371e1d148226b64c8edc77fec47fa5b] ACPI: UP build fix for bugzilla-5737
git-bisect good 7e1f19e50371e1d148226b64c8edc77fec47fa5b


A had a second go - fed it the very first and last commit IDs in that tree.
 Same result.

bix:/usr/src/git26> git-bisect good
9011bff4bdc0fef1f9a782d7415c306ee61826c9 is first bad commit
diff-tree 9011bff4bdc0fef1f9a782d7415c306ee61826c9 (from 7e1f19e50371e1d148226b64c8edc77fec47fa5b)
Author: Len Brown <len.brown@intel.com>
Date:   Thu May 11 00:28:12 2006 -0400

    ACPI: delete newly added debugging macros in processor_perflib.c
    
    Signed-off-by: Len Brown <len.brown@intel.com>

:040000 040000 f7a3b4cfdb128fb6a777b2e30a83c63edd70f46a 2ca1c42aaae65df9052d60d274aaec3116e30c2d M      drivers
bix:/usr/src/git26> cat .git/BISECT_LOG       
git-bisect start
# good: [74951d613e758f9709d6f2173107be68f18f77f4] ACPI: Remove debugging macros from drivers/acpi/thermal.c
git-bisect good 74951d613e758f9709d6f2173107be68f18f77f4
# bad: [9011bff4bdc0fef1f9a782d7415c306ee61826c9] ACPI: delete newly added debugging macros in processor_perflib.c
git-bisect bad 9011bff4bdc0fef1f9a782d7415c306ee61826c9
# good: [c52851b60cc0aaaf974ff0e49989fb698220447d] P-state software coordination for speedstep-centrino
git-bisect good c52851b60cc0aaaf974ff0e49989fb698220447d
# good: [7e1f19e50371e1d148226b64c8edc77fec47fa5b] ACPI: UP build fix for bugzilla-5737
git-bisect good 7e1f19e50371e1d148226b64c8edc77fec47fa5b


What did I do wrong this time?

Thanks.
