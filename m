From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 4/8] Support remote helpers implementing smart
	transports
Date: Wed, 2 Dec 2009 09:04:57 -0800
Message-ID: <20091202170457.GC31648@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi> <20091201192233.GL21299@spearce.org> <20091202055543.GC31244@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:05:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsdX-00050Z-4R
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbZLBREz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755069AbZLBREz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:04:55 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:64095 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbZLBREy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:04:54 -0500
Received: by yxe17 with SMTP id 17so320716yxe.33
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 09:05:01 -0800 (PST)
Received: by 10.101.213.35 with SMTP id p35mr358117anq.72.1259773500952;
        Wed, 02 Dec 2009 09:05:00 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 34sm629831yxf.11.2009.12.02.09.04.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 09:04:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091202055543.GC31244@Knoppix>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134350>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> On Tue, Dec 01, 2009 at 11:22:33AM -0800, Shawn O. Pearce wrote:
> > Why both connect-r and invoke-r?  Why isn't connect-r sufficient
> > here?  Isn't it sufficient for any service that runs over git:// ?
> 
> Invoke supports those --upload-pack &co (a'la ssh://). connect
> doesn't (a'la to git://).

Drop invoke-r.

Modify transport-helper.c to allow pushing TRANS_OPT_UPLOADPACK and
TRANS_OPT_RECEIVEPACK down into the helper via the option capability.

I'd rename connect-r to just connect.

For the command line:

  $ git fetch --upload-pack='/path to my /git-upload-pack' origin

The conversation with the helper will be:

  > capabilities
  < option
  < connect
  <
  > option uploadpack /path to my /git-upload-pack
  < ok
  > connect git-upload-pack
  <

Which gives the helper the full information it needs to pass along
the --upload-pack command line argument to the remote system.

-- 
Shawn.
