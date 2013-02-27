From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: clean/smudge filters on .zip/.tgz files
Date: Wed, 27 Feb 2013 16:18:17 +0100
Message-ID: <512E23B9.4070000@drmicha.warpmail.net>
References: <20130226163800.454cd093@bigbox.christie.dr> <512DAA0E.9010401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tim Chase <git@tim.thechases.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 27 16:18:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAimI-00017b-8o
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760252Ab3B0PSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:18:17 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35901 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760239Ab3B0PSP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2013 10:18:15 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 52D3920BD3;
	Wed, 27 Feb 2013 10:18:14 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 27 Feb 2013 10:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/u4viXVJw5KFPQijkCE7ya
	egcNc=; b=SszrqsX4yY8i7K/teO1IXXUosKwmT5YTF8Nlx5Sgr6MqQvuZbdZoUt
	Zr/k7EF+Vx5a/2Vn82gT9QRkKSmeSzcy6DFiHmZJu7P94tQXprr+Cc7Cs1nXeNyT
	4KGajR7raz2bnGsZLEtUO9gy3Sd6xJADEyCCjFdVjIaOVgw167/qA=
X-Sasl-enc: oIffgegufo3pKjsllM+strXy1PB5b7hCyZv58esqOfwc 1361978294
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B0E18C80E8B;
	Wed, 27 Feb 2013 10:18:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <512DAA0E.9010401@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217208>

Johannes Sixt venit, vidit, dixit 27.02.2013 07:39:
> Am 2/26/2013 23:38, schrieb Tim Chase:
>> Various programs that I use ([Open|Libre]Office, Vym, etc) use a
>> zipped/.tgz'ed file format, usually containing multiple
>> (usually) plain-text files within.
>>
>> I'm trying to figure out a way for git to treat these as virtual
>> directories for purposes of merging/diffing.  
>>
>> Reading up on clean/smudge filters, it looks like they expect one
>> file coming in and one file going out, rather than one file
>> on one side and a directory-tree of files on the other side.
>>
>> I tried creating my own pair of clean/smudge filters that would
>> uncompress the files, but there's no good way put multiple files on
>> stdout.
>>
>> Has anybody else played with such a scheme for uncompressing files as
>> they go into git and recompressing them as they come back out?
> 
> I attempted to do something like this for OpenDocument files (I didn't get
> very far) until I discovered that LibreOffice can save "flat open document
> files". That combined with the option "save files optimized" switched off
> results in fairly readable XML in a single file that can even be merged
> under some circumstances.
> 
> You would still need a clean filter that normalizes the style numbers,
> cross reference marks and other stuff that changes each time LibreOffice
> saves the file.
> 
> -- Hannes
> 

In general, using "zip -0" is a good way of getting something that
delta-compresses well and that can give a meaningful diff (and has no
information loss).

The (my) problem is that recompressing a zip archive (i.e. multi-file)
is a pita, you can't just use a pipe "unzip | zip -0". You'd have to do
that in a temp dir.

Michael
