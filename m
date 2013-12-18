From: Jonathan Nieder <jrnieder@gmail.com>
Subject: incremental fast-import and marks (Re: I have end-of-lifed cvsps)
Date: Wed, 18 Dec 2013 08:23:34 -0800
Message-ID: <20131218162239.GA26668@google.com>
References: <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <20131217140746.GB15010@thyrsus.com>
 <CANQwDwe8AcbCYG5GZcY1tn9BN0x5KWux_CNQY2OWG+qZJ5rS4Q@mail.gmail.com>
 <20131217210255.GA18217@thyrsus.com>
 <CANQwDwdQZGhR=hhFHe7wRAeNej_F5fHspN7+f-LiJu06utwC-w@mail.gmail.com>
 <20131218002122.GA20152@thyrsus.com>
 <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@thyrsus.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 17:23:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtJuW-0004O9-3i
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 17:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab3LRQXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 11:23:44 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:40355 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab3LRQXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 11:23:43 -0500
Received: by mail-yh0-f42.google.com with SMTP id z6so5391086yhz.15
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i8wxVypVK6ysVhYR56V/0Hq2IovSSB8T4wKZ00Ncdfk=;
        b=FzR2D/CN2V9kFY6OcorACaaePN+YDnye4+9Hso7FZrUjczlWG2SN5nkOVcwsp77v6q
         hkt6Y8U7/d53vuFcMxuVeDnR+zWeuPX1uG+L4nz5FkRvNNq5OyTlWeDGCurRGRJlk6vx
         ke0BlbmWxNOLSNbwc7kS4gcDBfpPSakNxUzgQoU9J8i/s6M9OJVbLVn7Y1/a00vMc6VZ
         nzHIFmmf7EkY4UmYXi44pNG8B9jXgPSQvi+IYx+auXnhwQ8XtuV+YEPsourzpUL2SOyG
         2maihhh3ntEAK05axCiD6KXU9ygdZ5qRy7GXan50OAKb0HsiIVdyWT8bQ+f8Fh0OUHSc
         NVgg==
X-Received: by 10.236.28.162 with SMTP id g22mr23228222yha.52.1387383822602;
        Wed, 18 Dec 2013 08:23:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id r98sm956482yhp.3.2013.12.18.08.23.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 08:23:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANQwDwdgZUWcgyZCWoDni+e9jgQ+8j0Yn_HMxiMn5OHzsRzjwQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239453>

Jakub Narebski wrote:

> It is a bit strange that markfile has explicitly SHA-1 (":markid <SHA-1>"),
> instead of generic reference to commit, in the case of CVS it would be
> commitid (what to do for older repositories, though?), in case of Bazaar
> its revision id (GUID), etc.

Usually importers use at least two separate files to save state, one
mapping between git object names and mark numbers, and the other mapping
between native revision identifiers and mark numbers.  That way,
when the importer uses marks to refer to previously imported commits or
blobs, fast-import knows what commits or blobs it is talking about.
