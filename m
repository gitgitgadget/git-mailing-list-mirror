From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: fast-import issues with monotone
Date: Tue, 9 Sep 2008 02:37:20 +0300
Message-ID: <94a0d4530809081637g23543c41w28e6039a75b85fa2@mail.gmail.com>
References: <94a0d4530809081530p60ff8692qbf9c314516d03869@mail.gmail.com>
	 <20080908223601.GB14448@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 01:38:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcqJS-00051l-Cj
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 01:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbYIHXhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 19:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbYIHXhW
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 19:37:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:31245 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbYIHXhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 19:37:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1647677rvb.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tJkTG6YKkkl5vF16FOYsKmmDczfsPCEaoHkA9ZQwzxI=;
        b=gO6SEFplTBqycC+gGL+VAV1T3n/x1gioW9zdWH8IruuW9YoU4q4dxZTZlt43uoDxgE
         aRa0a7n1iz/bl/liYm3hi4M2qCG0MqkZGi38hGVqYsIBSu7d0dR1jBrFlZNUcFw/gcgP
         6OGCiyV6QUInROU6EINiVBuI2y2n1v+SLdPmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l3Ovdkc76cPiogh3Nzaqw98oJlY7tnR7G/siDcme8/S0lw3cMnrBQVnCJlZPtGVDcd
         +loqInl+8b1Jsgbs9ideR5OENJ/gqxCWkgpkkqoDHdLJXepHNPiB3mDyfdFauI6fmB/M
         VJPSX9Gam2tM6vVXkKdvs+zHhsvJnTBF5HbQY=
Received: by 10.141.13.16 with SMTP id q16mr9241682rvi.99.1220917040895;
        Mon, 08 Sep 2008 16:37:20 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Mon, 8 Sep 2008 16:37:20 -0700 (PDT)
In-Reply-To: <20080908223601.GB14448@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95319>

On Tue, Sep 9, 2008 at 1:36 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> I'm stuck with yet another issue while trying to export a mtn
>> repository, so I thought on sharing the list of issues:
>>
>> a) directory rename/deletes are indistinguishable from files
>
> Hmm.  I had thought fast-import allowed you to rename or delete a
> directory by just name its path.  Internally it should be cascading
> those operations to all of the contained children.

Aha! I didn't notice that. I guess I assumed 'filedelete' was for files only :)

>> b) file mode changes are just like any other operation (you don't get
>> the mode at each revision)
>>
>> This means the file mode needs to be tracked all the time. Also, it
>> means the file contents (blob) needs to be tracked because sometimes
>> the only change in the file is the mode.
>
> Ow.  I could see a special case being introduced into the language as
> placeholders for the fields, telling gfi not to replace the data if
> it is already present.  Probably not even a very difficult patch
> to add.  E.g. make "-" a placeholder for both mode and content
> SHA-1/mark.

Yeap, I thought about something that. I'll implement it then.

>> For these two issues the only viable solution is to keep track of the
>> whole tree of each revision. Does it makes sense to do that? Or would
>> it make more sense to modify fast-import to allow more delta-oriented
>> operations?
>
> Most frontends do keep track of everything.  The CVS->Git and
> CVS->SVNish->Git keep track of everything just so they can order
> things across files to form commits/changesets.

Well, CVS/SVN are special cases, are they using fast-import? In any
case, I guess there's no way to make those generators simple, but I
don't think for DSCMs generators should be that complicated.

-- 
Felipe Contreras
