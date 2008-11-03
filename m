From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7700: demonstrate mishandling of objects in packs with
 a .keep file
Date: Mon, 03 Nov 2008 12:20:04 -0600
Message-ID: <RqVk2AkdyUcFTIGofSkQwl1GtBTXMYzMqaOQiAOmBXAyPDuWlQug-w@cipher.nrlssc.navy.mil>
References: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil> <14536526.1225596838300.JavaMail.teamon@b301.teamon.com> <490ED3FE.8040103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	nico@cam.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:28:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx49z-0005IA-BD
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbYKCS1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 13:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYKCS1E
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:27:04 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35385 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYKCS1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 13:27:03 -0500
Received: by mail.nrlssc.navy.mil id mA3IK4wK004241; Mon, 3 Nov 2008 12:20:05 -0600
In-Reply-To: <490ED3FE.8040103@op5.se>
X-OriginalArrivalTime: 03 Nov 2008 18:20:05.0049 (UTC) FILETIME=[CB5B3290:01C93DE0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99973>

Andreas Ericsson wrote:
> drafnel@gmail.com wrote:
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> Objects residing in pack files that have an associated .keep file are not
>> supposed to be repacked into new pack files, but they are.
>>
> 
> I think that's a misconception. Packfiles that are marked with .keep files
> should never be deleted. There are, afaik, no rules against packing the
> same objects into other packfiles as well. This is nifty for dumb ref
> walkers, as they can use a small pack for incremental fetching while using
> a mega-pack for initial cloning.

Having no rules against an object residing in more than one pack is different
from intending for git to produce pack files with redundant objects.

I think one intention for the .keep mechanism was to allow for a size optimized
pack to be produced and distributed. Currently, if I am handed such a pack file,
I can not merely place it into my pack directory (along with the .idx and .keep
files) and then run git-gc to remove any redundancy. Instead, I would get
a _new_ pack file which would contain all of the objects in the repository and
effectively double the size of my objects store. That doesn't seem like
something a user would expect or should expect.

-brandon
