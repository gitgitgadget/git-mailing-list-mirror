From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Cloning or pushing only files that have been updated
Date: Sat, 25 Apr 2015 23:54:36 +0200
Message-ID: <553C0D1C.2010301@kdbg.org>
References: <054116d47b69ca56f3369369df9fb4d8.squirrel@www.qgenuity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: cl@qgenuity.com
X-From: git-owner@vger.kernel.org Sat Apr 25 23:54:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym82J-0002rA-4P
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 23:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbbDYVyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 17:54:41 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:30313 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750727AbbDYVyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 17:54:40 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lZ5kP6QKkz5tlC;
	Sat, 25 Apr 2015 23:54:37 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B0EE4522C;
	Sat, 25 Apr 2015 23:54:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <054116d47b69ca56f3369369df9fb4d8.squirrel@www.qgenuity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267804>

Am 25.04.2015 um 23:17 schrieb cl@qgenuity.com:
> I have two sets of files.
>
> A_Old is a large unversioned directory tree containing many files.
>
> A_Updated is a git repository containing the files from A_Old, some of
> which have been modified. A_Updated also contains new files.
>
> I am looking for a way of cloning only the new or modified files from
> A_Updated to A_Old. I would like A_Old to become a clone of A_Updated,
> however I don't want to download the entire archive because of access
> speed issues.
>
> Timestamps on all files are accurate.

1. Create a commit from the files in each of the directories.

2. Use git rev-list --objects --all | sort to generate a sorted list of 
objects in each of the repositories.

3. In A_Old, generate a pack from the objects that are not in A_Updated 
using 'comm' of the objects lists piped into git pack-objects.

4. Transfer this pack from A_old to A_Updated.

5. Use git fast-export --no-data in A_old.

6. Use git fast-import in A_Updated to import the commit that you have 
in A_Old into A_Updated.

7. In A_Updated, git reset --soft the-commit-from-A_Old && git commit. 
Now you have a second commit with the updated state.

8. Use git-remote to connect the two repositories and to push or pull 
the updated state.

-- Hannes
