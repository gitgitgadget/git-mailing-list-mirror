From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 1/8] refs.c: add err arguments to reflog functions
Date: Wed, 08 Jul 2015 16:01:56 -0400
Organization: Twitter
Message-ID: <1436385716.4542.11.camel@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	 <559D0B42.1040607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:02:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCvXg-0004sb-Nr
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbbGHUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 16:02:00 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:35866 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbbGHUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 16:01:59 -0400
Received: by qgeg89 with SMTP id g89so105556225qge.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 13:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=HnMMorY2hxI+jEtFgvHdWjmDxX4QdosrLcohlNSJBPE=;
        b=EuDOxNAhuvSgqPzlZlcCej3sRPJy9ojgT4MtkMUgGN8zEnzDMo0z0NXrGXJ9umy3sg
         V7kFq1SZQd5NJldWHoKvD5SPYKO2vIwOOh5oXPeetl207lh7CKSmhHP1KqeGs02sSvXK
         zStKgz7/IerduqFthUQ+Lrj4iGTts6dzEN7TC0Z/9/zKod3H1E9/iEtqsttmoOCGBHhT
         g70lDVhNBIuXy+W2iBKNtJGeH+AQGowRofk9Y442OjQgtb9FSfo4s/1FJ8AixXIIQV3L
         APAsYApqjvQQIAC/8X0/pd8sbg3xXK5XbPMhmOUns4pYAWGI3FnkBcNZQigwTl2ZNQpk
         v1Ww==
X-Gm-Message-State: ALoCoQnGI3aOB98cbwxHnSlvnoBQtZXdzFnXtcZwc0Uk0QZH90iYgumTlBqJF01W0cA47yKwyPM+
X-Received: by 10.140.104.148 with SMTP id a20mr19095613qgf.89.1436385718693;
        Wed, 08 Jul 2015 13:01:58 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 80sm1989418qhr.26.2015.07.08.13.01.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 13:01:57 -0700 (PDT)
In-Reply-To: <559D0B42.1040607@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273704>

On Wed, 2015-07-08 at 13:36 +0200, Michael Haggerty wrote:
> On 07/08/2015 02:55 AM, David Turner wrote:
> > Add an err argument to log_ref_setup that can explain the reason
> > for a failure. This then eliminates the need to manage errno through
> > this function since we can just add strerror(errno) to the err string
> > when meaningful. No callers relied on errno from this function for
> > anything else than the error message.
> > 
> > Also add err arguments to private functions write_ref_to_lockfile,
> > log_ref_write_1, commit_ref_update. This again eliminates the need to
> > manage errno in these functions.
> > 
> > Some error messages change slightly.  For instance, we sometimes lose
> > "cannot update ref" and instead only show the specific cause of ref
> > update failure.
> 
> Did you check that the new error messages are at least as clear to the
> user as the old ones? (Sometimes errors from deep in the call stack
> provide details but don't make it clear how the details connect back to
> the action that the user was trying to do.)

They seem clear enough to me, but I guess there's no reason not to keep
the "cannot update ref" bit.  Will fix, along with the rest.
