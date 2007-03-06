From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a testcase for the safety of pull-policy='pull'.
Date: Tue, 6 Mar 2007 22:37:34 +0000
Message-ID: <b0943d9e0703061437t67f3be3s3358b4fe3ecb2b0a@mail.gmail.com>
References: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth>
	 <b0943d9e0702270625o5a9ef8b4xd0fa5df68e2b805a@mail.gmail.com>
	 <20070227210906.GH4045@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0702271538q32e6a9d5y6ac73adfc4854ab6@mail.gmail.com>
	 <20070228214851.GC4149@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070301201047.GD4149@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 23:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOiHq-0008Cg-MV
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 23:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbXCFWhf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 17:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbXCFWhf
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 17:37:35 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:64904 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030391AbXCFWhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 17:37:34 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2288569nze
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 14:37:34 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T/wIkNFB0SuzmbbvA0Ca698gJJ5m9hMdfHA24MUPbxdz6ED63dYEgf0+FJ+wI2soU4X/ZEjKVrx12zw8ljWY+0HDkbxi/FAD7X4MCQ6KmJYXpCUTX2Ml7B5YqlF5dSLWPC7+tW8+ENTQnpHAnBp9CL+o3tajI86taGb7We91A1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DmTHug7aWfdX4u/s3J1fbL8z+MiOzxbZeb6bYAnbri3HPSC5rwoR4F/aNVwv70Yf5f2vggSQxzn3Vit1Bv2U4yfMUddwL1QKForoHfhUNU/HkBqiHbsuEMyBi/YT5Rtht2OX/ar2D2OBdsRUZeruitpkXVXg32YSaS3TwnqwWL8=
Received: by 10.65.211.16 with SMTP id n16mr13049011qbq.1173220654285;
        Tue, 06 Mar 2007 14:37:34 -0800 (PST)
Received: by 10.65.96.9 with HTTP; Tue, 6 Mar 2007 14:37:34 -0800 (PST)
In-Reply-To: <20070301201047.GD4149@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41604>

On 01/03/07, Yann Dirson <ydirson@altern.org> wrote:
> On Wed, Feb 28, 2007 at 10:48:51PM +0100, Yann Dirson wrote:
> > On Tue, Feb 27, 2007 at 11:38:45PM +0000, Catalin Marinas wrote:
> > > I added it so that one cannot remove the local changes by doing a
> > > "push --undo" in error. You would have to explicitly ask for local
> > > changes removing with status --reset.
> >
> > At least, the message in that case should probably be made better,
> > when undoing to avoid having to resolve a conflict: the message says I
> > cannot undo because I have a conflict, whereas it is the exact reason
> > why I want to undo.

That's because of the order of the safety checks.

> > Especially, since the conflict markers are now auto-recorded, we could
> > simply allow undo in that case.
>
> Actually, I find the behaviour to be much worse than before: forcing
> the user to run "status --reset" before "push --undo" indeed brings
> the patch that conflicted in a state where it is partly committed.

I don't have a strong opinion on forcing status --reset before push
--undo anyway, so I can revert that commit (it bothers me a bit as
well :-)).

> Indeed, the problem may well be that we should not commit the
> unresolved conflict.  Why it has some value, recording it as if the
> user had refreshed the patch is probably not a good idea at all,
> precisely because we're mid-way in the push, and that the operation
> can be aborted without stgit knowing.

The idea of commit 0f4eba6a37c1a5454560b097873e5a22bfcde908 was to
only show the conflict files with 'stg diff' and also allow me to
later see how I fixed a conflict via the 'stg log (-p|-g)' command.
But this interim refresh shouldn't affect the backup information
(backup = False in Series.refresh_patch). Do you have a simple test
showing this problem?

Regards.

-- 
Catalin
