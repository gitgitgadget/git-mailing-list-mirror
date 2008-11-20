From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Media repositories and memory usage
Date: Thu, 20 Nov 2008 23:19:35 +0700
Message-ID: <fcaeb9bf0811200819v721a8d83s2890d8e19a3e4e4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"Tim Ansell" <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 17:22:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3CH3-0006aU-NN
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 17:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYKTQTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 11:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbYKTQTi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 11:19:38 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:19582 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYKTQTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 11:19:37 -0500
Received: by ey-out-2122.google.com with SMTP id 6so219241eyi.37
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=u6yRLsFFC/0qRz7eFx+6ouwex4VMbEzuuTEx9bLsSLg=;
        b=nXignQTdjYBoQcDeiB2llJwTBjK9v1mSgg3gNtWBlR7zSEOPBVvJMSnFcBEOG0cmub
         /a6XXCwuHs05pMvDahE9Rwx73tjfSpEkmIxDdgUimiguZAiLbTTciD/AMRr+rae1p257
         iY13N0dP1B5f4W0VqOB40iQ1aewg5OEG0Bzak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=FYlwwcmqLMp7ME8i0MxizwOpYSzc0priQib6xYgfFIF+oa1QRDYkc5fNlQpmznluCm
         0ITgMEHqEs5nps4pfKB4E3JGCQpCE4m0kA1ROguzFRiNgIWWo2ZNqkzQXy7QWnzvbtrG
         mmFvYRXX8z6X9Mz2wgif7ASOOz3fPI1bmB+l0=
Received: by 10.86.50.6 with SMTP id x6mr1669124fgx.71.1227197975297;
        Thu, 20 Nov 2008 08:19:35 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Thu, 20 Nov 2008 08:19:35 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101458>

Hi,

There is another aspect I did not see Tim mention in his slides:
memory usage with large blobs. Git has tradition of loading the whole
blob in memory for easy manipulation. It could consume a lot of memory
in large blob case (and particularly worse in mingw port because it
does not support mmap).

I see these operations that need access to blobs:
 1. checkout blobs
 2. checkin blobs
 3. diff/delta blobs

Diffing blobs should be avoided any way for large blobs. Checking in
blobs does not require lots of memory. I'm working on checkout case to
reduce memory footprint. Is there any other case that will need full
blob in memory?

PS. For checkout/checkin case, if you do any conversion, full blob in
memory is still needed. But I guess that is rare for large blobs.
-- 
Duy
