From: Manuel Woelker <manuel.woelker@gmail.com>
Subject: [EGIT] Blame functionality update
Date: Thu, 29 Jan 2009 18:35:28 +0100
Message-ID: <3d045c7e0901290935l3bddac0emcbaee0b4b2c5695f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 18:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSap1-000201-Ey
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 18:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbZA2Rfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 12:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbZA2Rfc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 12:35:32 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:42603 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbZA2Rfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 12:35:31 -0500
Received: by ewy14 with SMTP id 14so45963ewy.13
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=7wItkc/NXXh4S556E6gpEsOJ1ZocactE63k9MlMemqE=;
        b=xFRQcFZBtW1X+0bZUEQPDKZ/weAifIeVVLcjVq0sQt/vknrCfW+IvDT2bSfd/JFZ3Z
         dSS89uSHGATHIc3zY23S8U74aOiO67kyKhwPAxhfjtuSg56UQhnaZ+GGIUjLZFBbsFB2
         I7sC++5Csws9WMOqs8hTqZnoaOLrpTe1iLIc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ttNUarQkrstLziK7N+cKDYQ8gqcdfV9ICo1I88e+6SFW0NNNw6j5BohhRuFlHTQ0xV
         iBZ6W2teFmnzAMhDGZqkPLCDl+1q6Ov0cILc9jBme4MG3W2xj4rJ/zEnRDYc9ln52OdE
         I3VS1gNMpa1pfCVPUc44BrvZuxKkBKdvJrC3g=
Received: by 10.103.171.6 with SMTP id y6mr157732muo.31.1233250528657; Thu, 29 
	Jan 2009 09:35:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107707>

Hi folks,

quick update about the state of blame functionality in my egit branch
at http://github.com/manuel-woelker/egit/tree/blame
Screen shot here: http://docs.google.com/View?docid=df5rvczr_3f46vd2ds

- Diff support: I changed the IDiff as suggested to work on raw bytes
and IntList's. I also yanked the Diff implementation from wicket and
adapted it for use in jgit. The diff stuff now lives in its own
package. I also added some basic tests to see if plugged diff
implementations conform to the required expectations.

- log support: I added an OriginWalk in the new log package that
traces ancestry of a file though history (including renames and
copying). This might also be neat for the history page, which does not
seem to follow renames at the moment (think "log -C -M"). This is just
a rough sketch atm. Copies are disabled right now, cause the
performance is abysmal, and the current implementation tries to trace
the ancestry of empty lines back to the triassic period. So this could
definitely be optimized. The OriginWalk itself uses RevObject (as
suggested) so it should be a little faster. The implementation
currently traces the different strands of ancestry quite naively,
possibly parsing commits multiple times. This could be improved to a
single pass walk, but this makes the algorithm a little less
straight-forward and I haven't gotten around to that.

- As a result of the the OriginWalk mentioned above, the blame
implementation has been refactored slightly, while still keeping the
basic structure.

- I hooked up the blame functionality to the UI which was easier than
anticipated. I am quite pleased with the result (see screen shot
above). The only thing that proved a little tricky was history and
annotation ruler selection listener notifying each other recursively.
For now I stopped the stack overflow by detecting that recursive call.
If anyone got a better solution just give me a shout.

Feedback, comments and criticism are welcome as always.

Cheers
  - Manuel
