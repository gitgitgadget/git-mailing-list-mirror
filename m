From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 15:14:00 +0700
Message-ID: <CACsJy8DSt8V1u2pWFQ6OcSWyKrVVnnnmWpvo5vk_u6QXkqkbcw@mail.gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com> <20160302023024.GG17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Josh Triplett <josh@joshtriplett.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Al Viro <viro@zeniv.linux.org.uk>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:14:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab1vc-0006Fs-Lu
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbcCBIOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:14:33 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35960 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbcCBIOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:14:31 -0500
Received: by mail-lf0-f42.google.com with SMTP id l83so82455685lfd.3
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 00:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZjM/CvHBpzdH8BG3hYqf5byaIkfAUvBmZDh96DiPeWU=;
        b=x/+1aoaE94OdLu9+kGzg8YfEbSCiv3DlahADR2ZYpWnJk5X4P+hMQb/90QPhdrxOsJ
         QVVAE9pIGBXUjMf3px3Fmhqc+xxuphP+MzTQZA2LPUYqIUrWceduak2jGjTu4fW7IJek
         Jw9VbVNsNjZmSQZQInFowNdOq+pnYXD0HGwy3B5W/FyfM04/Hc0IubLL9RmNVWWo41z6
         4j+LjPx0xWHqVhOmo0OfoZCSOydVhUyrSGsOs/N/RLwHlQlE8y3XwW49/1qzzk3YglkB
         /iHaNYFAXVA5kJd/0csVRqrxed3EuHkHEWPP+uXZ9zMsNV8ZixTcHjMfSCNYnFHGfJKe
         5B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZjM/CvHBpzdH8BG3hYqf5byaIkfAUvBmZDh96DiPeWU=;
        b=NoHEItkzhqWxSLVj5Vn3NKLOIFkumuWh/gtx15evncQAM1z28nsCKjrIvR5CpK4V4p
         ebUwbknKmY3q7sF7uaeQJTXsN9MFZSSsdpxJXGuPuSgcD7kK9GyOgEgDk2AEE81ZuOYj
         T8MFp44VxSU44/ruHDxXzl69/s1GATk3yoof3KrcAHG9g009Lui7kXtECnqIiXlQJnDh
         6zB9THVUi6XBmocpj7KlnJTPT+r7HQ3Nu8lgdS2AUVZN2xQdrUjUdJ8SUnchno0PruKF
         f2GIJT3iliKmK5Sjfl6lt5BVWP84eL609HjGg1o6FINqDvu8vLyuhbE0qMryOIpkwJ/n
         F+Uw==
X-Gm-Message-State: AD7BkJJLk/GGipGjOVct16DKQScM9VuWPA+NBfYric2zuY+qXL+9BRv6Vjli7AK56HS/r94bmcoa3E3r5nMAhQ==
X-Received: by 10.25.212.213 with SMTP id l204mr4904368lfg.118.1456906470149;
 Wed, 02 Mar 2016 00:14:30 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Wed, 2 Mar 2016 00:14:00 -0800 (PST)
In-Reply-To: <20160302023024.GG17997@ZenIV.linux.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288103>

On Wed, Mar 2, 2016 at 9:30 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> IIRC, the objection had been that the organisation of the pack will lead
> to many cases when deltas are transferred *first*, with base object not
> getting there prior to disconnect.  I suspect that fraction of the objects
> getting through would still be worth it, but I hadn't experimented enough
> to be able to tell...

No. If deltas refer to  base objects by offset,  the (unsigned) offset
is negated before use. So base objects must always sent first. If
deltas refer to base objects by full SHA-1 then base objects can
appear anywhere in the pack in theory. But I think we only use full
SHA-1 references for out-of-thin-pack objects, never to an existing
object in the pack.
-- 
Duy
