From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] Get rid of the non portable shell export VAR=VALUE costruct
Date: Thu, 22 May 2014 15:57:40 +0200
Message-ID: <CA+EOSBkmZRd7FiTNUfDPrUX4NivHR7HUL-+UqDzcpE+X7BQcOA@mail.gmail.com>
References: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>
	<537DF7F2.8000401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, dak@gnu.org
X-From: git-owner@vger.kernel.org Thu May 22 15:57:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnTVC-00074O-70
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 15:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbaEVN5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 09:57:42 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:64254 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaEVN5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 09:57:41 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so1076615vcb.23
        for <git@vger.kernel.org>; Thu, 22 May 2014 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9eZuFGU23NHXY1ORqVug6QX0XX9bLrP3SYvdApfAabk=;
        b=fh7zpb1aGTOWkWb4wocJlkrhqe3BiF4T0rQE49wKAx0VU8KPj7vcZ40FmIMXuoQw09
         tkBFEHq5uavNPiI98WB9tHFLrdKjbsMJh1M/48xM6XQj4ZyermuloW6dmahe49wqBsWk
         eJg9PwF5DAd/47KpYQP/5a4cDVLhMndEkqVWQAX8X+S4HW+6IomMTv3AeyFtk8N9BY++
         4pDfLI0LxHsINDixzUFBm2T18TE4Lwl2713KZlX8kB/DOoBr2dTWvjX6sDZikxl8TKUx
         J9Jh3iA2YkvUkH+agqecz2hqpC976X0EINh+6I9jn3/CvCUpiP2tUB2tpw5B1XSm6NXy
         +tlA==
X-Received: by 10.58.29.234 with SMTP id n10mr8117029veh.16.1400767060863;
 Thu, 22 May 2014 06:57:40 -0700 (PDT)
Received: by 10.52.163.207 with HTTP; Thu, 22 May 2014 06:57:40 -0700 (PDT)
In-Reply-To: <537DF7F2.8000401@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249903>

5-22 14.48, Elia Pinto wrote:
>> Found by check-non-portable-shell.pl
>
> Thanks for picking this up
>> -export TEST_DIRECTORY=$(pwd)/../../../t
>> +TEST_DIRECTORY=$(pwd)/../../../t && export TEST_DIRECTORY
> Minor remark:
> Both commands should go on their own line, like this:
>
> TEST_DIRECTORY=$(pwd)/../../../t &&
> export TEST_DIRECTORY
>
Apparently they are both common idioms and I find no indication in the
CodingGuideline.

I have no problems rerolling  this simple patch, but i need to know
what is the (git) right style in this case.

Thanks
------

cd ./git-core

 grep "&&.*export" *.sh
git-am.sh:          GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
git-filter-branch.sh:   echo "case \"\$GIT_$1_NAME\" in \"\")
GIT_$1_NAME=\"\${GIT_$1_EMAIL%%@*}\" && export GIT_$1_NAME;; esac"
git-filter-branch.sh:   GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
git-rebase--merge.sh:           GIT_MERGE_VERBOSITY=1 && export
GIT_MERGE_VERBOSITY
git-remote-testgit.sh:GIT_DIR="$url/.git" && export GIT_DIR
git-stash.sh:                           GIT_INDEX_FILE="$TMPindex" &&
export GIT_INDEX_FILE &&
git-stash.sh:           GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY

grep 'export.*&&' *.sh
git-stash.sh:                           GIT_INDEX_FILE="$TMPindex" &&
export GIT_INDEX_FILE &&
git-stash.sh:                   export GIT_INDEX_FILE &&

>
> And, unrelated to this patch,
> there seem to be a lot of && missing in git-remote-testgit.sh.
> But this should be a seperate patch, I think.
>
>
>
