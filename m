From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [git wiki PATCH 1/3] "Improving parallelism in various commands" project
Date: Fri, 2 Mar 2012 21:29:22 +0700
Message-ID: <CACsJy8APtrw-6umkr3=yrG3wfye96=z=CvfWj0tnghfDcDWFzg@mail.gmail.com>
References: <20120302091114.GA3984@sigill.intra.peff.net> <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:30:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3TUf-0004Ua-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 15:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847Ab2CBO3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 09:29:54 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:45257 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab2CBO3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 09:29:53 -0500
Received: by wejx9 with SMTP id x9so1075662wej.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 06:29:52 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.81.37 as permitted sender) client-ip=10.180.81.37;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.81.37 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.81.37])
        by 10.180.81.37 with SMTP id w5mr3386729wix.16.1330698592466 (num_hops = 1);
        Fri, 02 Mar 2012 06:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=E4Xu1Hkb3aPIgb4hUdNxSqdHL3C3h7yDHEdpw7uHOPM=;
        b=0PGcvqWRDjprMT669nakGau5h5z4lwhM2WjnKON0FijidmryrkPmwks28eVreHVNki
         Q6UNXgviYuINWU8EjeleWdrvK3RaSK7ZExXpaCh7ebu+kbUH2+hRo5WxTBGiqy9ZtbBq
         2Gbo9O/KT8/3dv3clgM17Y/eL61zcSGCOVYRh2eBHCuC4ivPuRStkg3dBsQFHO5+fnuR
         0qQBm0SUKBHJ8UMVoQPfMmI6zOUpex590xxBtF8n1YdkuQA2fZOzJtVGxEE5g4owi+u8
         pg31ifnHw2Ap5IIElt3qnKB9tLBwFYtlgfjaSO8DCnkRvh7jEPYe0TzEIPfk2evgB0i7
         Bmcw==
Received: by 10.180.81.37 with SMTP id w5mr2705917wix.16.1330698592302; Fri,
 02 Mar 2012 06:29:52 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Fri, 2 Mar 2012 06:29:22 -0800 (PST)
In-Reply-To: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192045>

On Fri, Mar 2, 2012 at 6:05 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> + * In preparation (the half-step): identify commands that could
> + =C2=A0 benefit from parallelism. =C2=A0`git grep --cached` and `git=
 grep
> + =C2=A0 COMMIT` come to mind, but most likely also `git diff` and `g=
it log
> + =C2=A0 -p`. =C2=A0You can probably find more.

I just had a thought this afternoon whether "git add" may benefit from
parallelism. It's most likely I/O-bound, although I think if we add a
bunch of large files, it might become CPU-bound. To generalize,
anything that calls hash_sha1_file() might benefit from parallelism.

Another candidate may be git-apply. Actually I just want to speed up
git-rebase and think git-apply may be the culprit. Or it could be
unpack-trees code..
--=20
Duy
