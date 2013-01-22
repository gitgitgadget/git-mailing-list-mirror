From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822
 continuation in footer
Date: Tue, 22 Jan 2013 01:47:20 -0800
Message-ID: <20130122094720.GA8908@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-2-git-send-email-drafnel@gmail.com>
 <20130122075413.GB6085@elie.Belkin>
 <CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 10:48:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxaSb-0001Vk-Q3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 10:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab3AVJrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 04:47:42 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:52906 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab3AVJr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 04:47:29 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3138728dak.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 01:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ioKy2uWZKWNcY+NxlRAhIw7pVsO65OLRMuxu2KfbPFE=;
        b=a/PMoLuuWx60Lzz9pv55k6mO7ZXScnKouCANFrk5XDteyrwU0S+wh3vDuTIBnYdZrW
         hoAgQ27K+J+lpUJ2g+6X1Saesj1BiPoE1+7LjM1dAqDZgQlSxtnRg7rJgiXgmZiYcK6O
         AkynxD7c++tvQK/lq2vgcfzMsufCJihOc8P2wnJwSPDR4INj2Z30B/tIhqJffcnNKNxe
         aiWI4OSM8/TCMgbfOKabNJJPlrl4/iUY5O3DYLlfvAs+ZTe/6rJOZpj7NeNb8wFTljH+
         nc69ME5Ie0zP1lCWW8HAsgFoLL+LzYj2UbVHpfG/FaIqogJ+Nz7Rvc4pNuxmASfUoe/A
         A+8w==
X-Received: by 10.68.223.131 with SMTP id qu3mr37533805pbc.89.1358848048657;
        Tue, 22 Jan 2013 01:47:28 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id mz10sm10447427pbc.37.2013.01.22.01.47.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 01:47:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214227>

Brandon Casey wrote:
> On Mon, Jan 21, 2013 at 11:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> First (snipped), it seeks back two newlines from the end and then
>> forward to the next non-newline character, so (buf + i) is at the
>> start of the last line of (the interesting part of) sb.
>
> Did you catch that the two newlines have to be adjacent to each other?
[...]

Here is the loop in master:

	int hit = 0;
[...]

	for (i = len - 1; i > 0; i--) {
		if (hit && buf[i] == '\n')
			break;
		hit = (buf[i] == '\n');
	}

I don't see any adjacency check.  I agree with you that "two adjacent
newlines" was probably the intent, though.
