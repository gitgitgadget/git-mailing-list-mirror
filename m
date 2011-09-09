From: mfwitten@gmail.com
Subject: Re: [PATCH] send-mail: Add option to sleep between
                                sending each email.
Date: Fri, 09 Sep 2011 02:12:20 -0000
Message-ID: <eba7fd939a4945a9bfe18afc125c3962-mfwitten@gmail.com>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org>
            <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com>
            <vpq7h5jtngj.fsf@bauges.imag.fr>
            <7vbouvx8j5.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Georgi Chorbadzhiyski <gf@unixsol.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 04:17:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1qeb-0001du-6f
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 04:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552Ab1IICRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 22:17:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40256 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515Ab1IICRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 22:17:09 -0400
Received: by bke5 with SMTP id 5so1226272bke.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 19:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:subject:date:to:cc:message-id:in-reply-to:references;
        bh=W80qqcZjSFMn3hgef7MmBlJEw511DapGlgMAx4HS5ok=;
        b=h7kcHhs7TmmMSqE/v5sAjn6ZWswGlM3mKScXR9wecoXgx1nQkTlOw3AAbflY5wrjsh
         BuarFpYFFcLTMcQRuNOMOX84IecgnL1VA9x2iKz5O3pmo5ZlTWCd8wXt8UDppwsBCBK1
         KhvUyCf6hf0WTVZXp89q/YuvLa+yhQMWXzbBk=
Received: by 10.204.140.204 with SMTP id j12mr945568bku.386.1315534627773;
        Thu, 08 Sep 2011 19:17:07 -0700 (PDT)
Received: from gmail.com (raskin.torservers.net [74.120.15.150])
        by mx.google.com with ESMTPS id b17sm1485406bkd.8.2011.09.08.19.17.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 19:17:06 -0700 (PDT)
In-Reply-To: <7vbouvx8j5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181022>

On Thu, 08 Sep 2011 10:12:46 -0700, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> There have been discussion (and IIRC a patch) proposing this already in
>> the past. One advantage of sleeping a bit between each email is that it
>> increase the chances for the receiver to receive the emails in the right
>> order.
>
> Huh? Even in the presense of MTAs in the middle that are free to reorder
> messages?
>
> IIRC, "git send-email" does its best to force ordering by assigning
> monotonically increasing timestamps on the Date: field, so that the
> recipients can sort the messages based on it, in addition to the
> In-Reply-To field to help threading. I personally do not think there is
> anything more than that that should done in the program.

The previous, rather lengthy discussion involved my patch and took place
over 2 years ago. The thread starts here:

  Message-ID: <1239139522-24118-1-git-send-email-mfwitten@gmail.com?
  http://thread.gmane.org/gmane.comp.version-control.git/115988

continues here (because of my email header mistake):

  Message-ID: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
  http://thread.gmane.org/gmane.comp.version-control.git/116083

and ultimately, the final patch review was proferred here:

  Message-Id: <1239647037-15381-11-git-send-email-mfwitten@gmail.com>
  http://article.gmane.org/gmane.comp.version-control.git/116471

>From a quick glance, my patch would appear to have become more advanced,
as per your own request, Junio:

  Message-ID: <7vskkh1va5.fsf@gitster.siamese.dyndns.org>
  http://thread.gmane.org/gmane.comp.version-control.git/116083

Here's the documentation I wrote for it:

  diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
  index 5f7d640..236e578 100644
  --- a/Documentation/git-send-email.txt
  +++ b/Documentation/git-send-email.txt
  @@ -178,6 +178,36 @@ Automating
   	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
   	value; if that is unspecified, default to --signed-off-by-cc.
   
  +--sleep=<seconds>[,<burst>]::
  +	This option specfies that send-email should sleep for <seconds>
  +	after sending <burst> messages as quickly as possible; <seconds>
  +	should be an integer >= 0 and <burst> should be an integer >= 1.
  +	This mode of operation attacks 2 problems: email throttling and
  +	arrival disorder. Default is the value of the 'sendemail.sleep'
  +	configuration variable, or '0' if that does not exist.
  ++
  +By default, send-email tries to send one patch per email as quickly as
  +possible. Unfortunately, some email services restrict a user by refusing
  +to send more than some maximum number of email messages, M, in a given
  +period of seconds, S. This can be troublesome if the patch series has
  +more than M patches, because the server will ultimately refuse to send
  +some of them. In this case, simply pass '--sleep=S,M' or '--sleep S,M'
  +or set sendemail.sleep to 'S,M'.
  ++
  +Moreover, the emails often arrive at the final destination out of order;
  +though send-email manipulates the date fields and usually chains subsequent
  +emails via the In-Reply-To headers, some mail viewers nevertheless insist
  +on presenting them by order of arrival. This may be mitigated by using
  +something like '--sleep 60' (the equivalent of '--sleep 60,1'), so that
  +there is a 60 second delay between sending any two messages.
  ++
  +*Note*: Because of varying routes and batching schemes, there is no delay
  +that can guarantee the correct arrival order. Obviously, one solution is to
  +choose an obscenely large number, so be prepared to run send-email in the
  +background. Of course, spreading emails across time makes it more likely
  +that unrelated email messages arrive between patches. Therefore, send-email
  +warns you if both --sleep and --no-chain-reply-to are used.
  +
   --suppress-cc=<category>::
   	Specify an additional category of recipients to suppress the
   	auto-cc of:

Sincerely,
Michael Witten
