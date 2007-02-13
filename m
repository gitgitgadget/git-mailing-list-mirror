From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-cvsserver doesn't respect core.sharedrepository
Date: Tue, 13 Feb 2007 16:05:27 +0000
Message-ID: <200702131605.29088.andyparkins@gmail.com>
References: <200702131438.30291.andyparkins@gmail.com> <Pine.LNX.4.63.0702131611010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 17:06:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH0AD-0004zi-00
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 17:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbXBMQFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 11:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbXBMQFg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 11:05:36 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:62157 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXBMQFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 11:05:34 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2312658wxd
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 08:05:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jAGK4M6ijLLNy0agxfAiqusMIzPXhrGxikcek3Nv0uMQUV/D6Ubv9nWy5davyFA+kU1ZeuF4Bv8l3CRBvS1yrQkGGlpF1HTLOkD46oiDAjnQ31G6uavBAH1o1mcgAJxnvgYdvyNTNpa4HJV57ByQkeKUbwyKCY59ziOsAkVb28U=
Received: by 10.90.68.15 with SMTP id q15mr19371080aga.1171382733653;
        Tue, 13 Feb 2007 08:05:33 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id y7sm12297739ugc.2007.02.13.08.05.31;
        Tue, 13 Feb 2007 08:05:31 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0702131611010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39538>

On Tuesday 2007 February 13 15:11, Johannes Schindelin wrote:

> Since ref updates are not write-into-existing-file, but rather
> write-into-new-file-and-replace-old, it should work, no?

That perhaps might be the explanation for the bad behaviour.  The ref is being 
updated in git-cvsserver by writing the new head hash into the lockfile then 
doing

    unlink($reffile);
    rename($lockfile, $reffile);

The lockfile is made with whatever umask is in place, so the 
sharedrepository=group is being ignored.  The solution then is to use the 
permissions of the existing reffile when creating the lockfile.

Thanks Johannes.  One little sentence and it all becomes clear :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
