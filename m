From: Chris Wilson <cwilson@vigilantsw.com>
Subject: Fix another file leak
Date: Thu, 6 Oct 2011 21:41:37 -0400
Message-ID: <20111007014136.GB10839@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 03:41:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBzRa-00020r-MH
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 03:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759372Ab1JGBlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 21:41:42 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53413 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758321Ab1JGBll (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 21:41:41 -0400
Received: by pzk1 with SMTP id 1so8392353pzk.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 18:41:41 -0700 (PDT)
Received: by 10.68.14.97 with SMTP id o1mr10209935pbc.0.1317951700951;
        Thu, 06 Oct 2011 18:41:40 -0700 (PDT)
Received: from localhost (c-67-180-177-185.hsd1.ca.comcast.net. [67.180.177.185])
        by mx.google.com with ESMTPS id e3sm25459634pbi.7.2011.10.06.18.41.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 18:41:40 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183052>

Hi,

Vigilant Sentry (our C/C++ static analysis tool) found that
commit 6d4bb383, added a file leak to builtin/fetch.c.

static int store_updated_refs(...
{  
    FILE *fp;
    ...
    fp = fopen(filename, "a");
    if (!fp)
        return error(_("cannot open %s: %s\n"), filename, strerror(errno));
    ....

    if (check_everything_connected(iterate_ref_map, 0, &rm))
        return error(_("%s did not send all necessary objects\n"), url);

Please close the file handle before returning from the function.

Thanks,
Chris

-- 
Chris Wilson
http://vigilantsw.com/
Vigilant Software, LLC
