From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git cat-file "literally" option
Date: Wed, 18 Feb 2015 07:47:25 -0800
Message-ID: <CAPc5daUWTRA=cziUsXEbwNrggA_3mhRsrfnVaQ-F7iEeSO7ATw@mail.gmail.com>
References: <54E45DD7.205@gmail.com> <54E48A96.8010301@gmail.com> <CACsJy8BJnHTyXhhJaCuZAzjm=Gd96EjANEw76j=3L92cmbX7HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: karthik nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 16:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO6qs-0005cJ-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 16:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbbBRPrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 10:47:46 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:59923 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbBRPrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 10:47:46 -0500
Received: by mail-ob0-f181.google.com with SMTP id vb8so3267516obc.12
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QXbQN6y2EsualgjPXABdX299E5z6YEmzpyGnnJxYgIQ=;
        b=VAaNmuVDBMVfRpxcsH7X049D9eoJleACqevyB+YQpECCAZn84VrT4z2mHRzcL/AvOq
         r5kZASZSvspB3/WLBfe9EOUij3y4KBl/AOLZ1tuYvSkxCUD1aGx+6ZLDgE7UAd5SuY4s
         IZUUBWj05WS+ba5CIZ/fZd+F0GdDNIhC/i569Vh/B/MuEweNEvm5Bd2veFSE2bsn0M0Z
         06fPt887qIZU6im74wX+iWH26crH9q6wlQGabfcb5wi/iMQ3tkTzVj0bAv+CjCWc8woT
         eFlhOrNGKWpdiIWKKUkIdwN9+Zz3FBTaQxFG3aKvz1xA3Nr2H58tXyWj+uZQNpNUaAxf
         7jOA==
X-Received: by 10.202.87.79 with SMTP id l76mr21370079oib.84.1424274465558;
 Wed, 18 Feb 2015 07:47:45 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Wed, 18 Feb 2015 07:47:25 -0800 (PST)
In-Reply-To: <CACsJy8BJnHTyXhhJaCuZAzjm=Gd96EjANEw76j=3L92cmbX7HA@mail.gmail.com>
X-Google-Sender-Auth: qKYojNHd9lbgTIcDnCiSl0FGCzM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264024>

On Wed, Feb 18, 2015 at 5:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> ... skip the enum object_type conversion. You probably need special
> treatment for packed objects too.

I do not think you can store object of type "bogus" in a pack data stream
to begin with, so I wouldn't worry about packed objects.

"cat-file --literally" that does not take "-t" would not be useful, as the
output "cat-file <type> <object>" does not tell what <type> the thing
is. Other things like sizes and existence can be inferred once you have
an interface to do "cat-file <type> <object>", so in that sense -e and -s
are not essential (this also applies to "cat-file" without --literally).

By definition, "--literally -p" would not be able to do anything fancier than
just dump the bytes (i.e. what "cat-file <type> <object>" does), as the
bogus type is not something the code would know the best external
representation for.
