From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 21:08:55 -0600
Message-ID: <20101217030855.GB7003@burratino>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
 <201012170254.13005.trast@student.ethz.ch>
 <9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Elijah Newren <newren@gmail.com>, skimo@kotnet.org,
	Eric Raymond <esr@snark.thyrsus.com>
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 04:09:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTQh5-0006hH-76
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 04:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198Ab0LQDJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 22:09:14 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63744 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab0LQDJO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 22:09:14 -0500
Received: by yxt3 with SMTP id 3so107532yxt.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 19:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6HtVJNOE6tuZhi55RoA24PPqGsxCDSefLm34/1hhu9A=;
        b=jcUHldv+bm4Ln5HtsoB7qctSXYuFI5WblG0Pavcr4VHiHxZF9pjXcx0dGXWcBvBV6c
         nPtlkrB8vNORtbHZIkQg7whTRVtFJHcdDQ1GIjQbg83ShzEUUJqPjF6MYCvZlpWamtpS
         hF0xz5ugQta12LptAk9aKbj1b7VLPUQxz2zXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AoJv9xxrbtRUVzVoU4YqPyLyFYUcoBaVAUQ9a5oPl9dRTjQX0YkDkEMUtB/MDsCR8A
         Kb78o7xYS30eC59QTCegUPkUCfd9ZrlExMRY+2nhr7qMuR4RQJZSXEr/ujsRFGeZPRtD
         SlU0RP9rCdpFM+GK8LmhMXaPWPb6MaHsDBqmQ=
Received: by 10.100.120.18 with SMTP id s18mr263838anc.268.1292555352900;
        Thu, 16 Dec 2010 19:09:12 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id p9sm3645885anf.27.2010.12.16.19.09.10
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 19:09:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9A686258-A504-4CBB-9993-048B45B5EE6A@irridia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163855>

Ken Brownfield wrote:

> I had considered this approach (and the one mentioned by Jonathan)
> but there are no git tools to actually perform the filter I wanted
> on the export in this form.

Keep in mind that the two suggestions were subtly different from one
another.

For the "filter fast-import stream" technique, apparently there is a
tool called reposurgeon[1] to do that.  git_fast_filter[2] has the
same purpose, too, if I remember correctly.

For the unpack-trees avoidance technique, true, the only example I
know if is the one I mentioned[3].  The idea would be to sort the
commits you want in topological order and replay them, for each one
going like so:

	M 040000 <old tree id> ""
	D bad/directory/one
	D bad/directory/two

using fast-import from git.git master.  (Older versions of fast-import
do not properly handle replacing the root directory, so if that sort
of compatibility is important, you'd have to use a directory listing
and fill in all the _good_ directories instead.)

I'd be glad to look at any work in this direction.  Something like it
would be useful for postprocessing when importing from svn repos.

Thanks,
Jonathan

[1] http://esr.ibiblio.org/?p=2718
[2] http://thread.gmane.org/gmane.comp.version-control.git/116028
and links therein
[3] http://thread.gmane.org/gmane.comp.version-control.git/158375
