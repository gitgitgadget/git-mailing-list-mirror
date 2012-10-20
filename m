From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] contrib/hooks: avoid requiring root access in usage
 instructions
Date: Sat, 20 Oct 2012 00:03:11 -0700
Message-ID: <20121020070311.GB17969@elie.Belkin>
References: <20121020003104.GA26596@elie.Belkin>
 <7vzk3hhj1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Olivier Berger <olivier.berger@it-sudparis.eu>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kevin P. Fleming" <kpfleming@digium.com>,
	Chris Hiestand <chiestand@salk.edu>,
	Miklos Vajna <vmiklos@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 09:03:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPT5j-0004d5-W4
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 09:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab2JTHDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 03:03:16 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:64954 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab2JTHDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 03:03:15 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so565654dak.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 00:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DnbSXoV2/iU513RHxtbzXWs7jWx4X1N5mNRmCUwrhCM=;
        b=n3DWTccCT+LyEBLjGs1tYjw7iVz7osRUdC5Y0Imq5hqmdmkMnNOJ5+B0qVaJbaAZjy
         jVJpHj0oj5J5QqebBqVI7v7X4vCdFOA2Rab3q3qz0oIAt7HDYIEwqpXPliAXVS3pmO8j
         wwshkt16Mh9jsMgEgIsHUoEZ1C8kl5zzXSCGz5RLgHQAkaCUMCcw151CtT/fAnttplK2
         APEyR9C1YiRIzv7N3Wm43MEnQmUyas99AbwkbzFAA7M4oK7NAxY3zhHn+oNCHTya5mEc
         k6YIMkLo33iTJXF9m4Kmuouh9XmciRm6TLhRK85LEh/uGbKe0wvUyi/iLSGrJsFVJ/Ph
         ZbPA==
Received: by 10.66.80.133 with SMTP id r5mr10663944pax.24.1350716595201;
        Sat, 20 Oct 2012 00:03:15 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id w4sm2312034paz.38.2012.10.20.00.03.13
        (version=SSLv3 cipher=OTHER);
        Sat, 20 Oct 2012 00:03:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzk3hhj1m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208080>

Junio C Hamano wrote:

> We already encourage casting-in-stone a particular version of the
> sample hook when a new repository is created by copying them from
> the template directory.  This prevents from surprising users when an
> updated version of Git changes the behaviour of these samples.  Even
> if you think bugs in older ones may be corrected in newer ones,
> silently updating the hook the user chose to use by inspecting one
> particular version is not something we would want to do lightly.

For context, the sample hooks you are talking about are the *.sample
files from the templates/ directory.  Except for post-update.sample,
most are not very useful out of the box, and they are very much
intended as examples to start people's thinking, as opposed to
something one-size-fits-all.

By contrast, the post-receive-email script from contrib is a complete
program with a well-defined behavior and configuration that have
stayed consistent while the details of its implementation improved.
It can be used by symlinking into place, but maybe a better set of
instructions would say

	# This script takes no arguments and expects the same input format
	# as git's post-receive hook, so if this script is at
	# /usr/share/git-core/contrib/hooks/post-receive-email (as it is
	# on Debian and Fedora), you can do
	#
	#  cd /path/to/your/repository.git
	#  echo '#!/bin/sh' >hooks/post-receive
	#  echo 'exec /usr/share/git-core/contrib/hooks/post-receive-email' \
	#	>>hooks/post-receive
	#  chmod +x hooks/post-receive

That would make it more obvious what I can do next if my post-receive
input should be passed both to post-receive-email and some other tool
(perhaps in a pipeline using "tee").

Hmm?
Jonathan
