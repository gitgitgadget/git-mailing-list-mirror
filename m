From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: Re: git grep performance regression
Date: Tue, 15 Jan 2013 07:36:28 +0000
Message-ID: <20130115073628.GA647@hobo.wolfson.cam.ac.uk>
References: <20130114223800.GA12708@hobo.wolfson.cam.ac.uk>
 <CACsJy8A7FLYqdY2Mt5pUq0nH3N8mbZ4crkYJYFfepp19c0aWhg@mail.gmail.com>
 <CACsJy8AnABCisgSVL7Qh_-uejAJA3x1kzy=4i+uXm3+90m5tuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 08:36:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv14m-0002Ny-QA
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 08:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524Ab3AOHgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 02:36:32 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:64940 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab3AOHgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 02:36:31 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so1983153wib.2
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 23:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yp9FVtdVneIYKw7brWDZYEDjO5wi5BRQurwhtXLEWvM=;
        b=U/smDpnQQgJY38pjH5ZLTwROVEqyYZLkQE+xOoyh+grM8mZYPdtmisvFp6RIfcfkyI
         VztpBeKmrevq0vqaAe8yl6oPBQEkk2/YFnB8XmAoCbpMQrDwhXyUkOdTU+Z3JUmaa0uj
         8gUhugXlhcL+kmjrZtW5Sk/+hFCkzR6PF3qvhw83MHs6sYaR5KtlStYViMsdnKoyMTr6
         3PWHW5sgPR6DmSbe7t9YEzfEVM8o6H7w+9hHwRoDnGzjELgXTKcvoo7BMIEpNTbl8UOP
         dR/WTg5j0OXGtEZ9PXwYpxNT2P4kbyCAS0Arzur8LsTP8xpQxQmdh3z7Kf/G/VE7n3GV
         jNBw==
X-Received: by 10.194.48.74 with SMTP id j10mr41577465wjn.36.1358235390480;
        Mon, 14 Jan 2013 23:36:30 -0800 (PST)
Received: from hobo ([2001:630:212:600:d63d:7eff:fe2c:aa8c])
        by mx.google.com with ESMTPS id bd7sm2434711wib.8.2013.01.14.23.36.29
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jan 2013 23:36:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8AnABCisgSVL7Qh_-uejAJA3x1kzy=4i+uXm3+90m5tuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213603>

On Tue, Jan 15, 2013 at 11:38:32AM +0700, Duy Nguyen wrote:
> dirlen is not expected to include the trailing slash, but
> find_basename() does that. It messes up with the path filters for
> push/pop in the next code. This brings grep performance closely back
> to before for me. Ross, can you check (patch could be whitespace
> damaged by gmail)?
> 

Yes, that did seem to bring back the performance to the old level.

I noticed that before the patch, the strace output was something like
this:
open("tools/vm/.gitattributes", O_RDONLY) = -1 ENOENT
open("tools/vm//.gitattributes", O_RDONLY) = -1 ENOENT
open("tools/vm//.gitattributes", O_RDONLY) = -1 ENOENT
open("tools/vm//.gitattributes", O_RDONLY) = -1 ENOENT
open("usr/.gitattributes", O_RDONLY)    = -1 ENOENT
open("usr//.gitattributes", O_RDONLY)   = -1 ENOENT
open("usr//.gitattributes", O_RDONLY)   = -1 ENOENT
open("usr//.gitattributes", O_RDONLY)   = -1 ENOENT
open("usr//.gitattributes", O_RDONLY)   = -1 ENOENT
open("usr//.gitattributes", O_RDONLY)   = -1 ENOENT

(and yes, the whitespace was damaged by Gmail!)

Regards
-- 
Ross Lagerwall
