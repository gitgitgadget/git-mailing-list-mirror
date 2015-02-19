From: Mike Hommey <mh@glandium.org>
Subject: Something wrong with diff --color-words=regexp?
Date: Fri, 20 Feb 2015 08:52:13 +0900
Message-ID: <20150219235213.GA1291@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 00:52:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOatL-0002AB-NT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 00:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699AbbBSXwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 18:52:19 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:47114 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502AbbBSXwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 18:52:19 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YOatB-0001Vc-6U
	for git@vger.kernel.org; Fri, 20 Feb 2015 08:52:13 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264122>

Hi,

I was trying to use --color-words with a regex to check a diff, and it appears
it displays things out of order. Am I misunderstanding what my regexp should be
doing or is there a bug?

$ git diff -U3 HEAD^ dom/base/nsDOMFileReader.cpp 
diff --git a/dom/base/nsDOMFileReader.cpp b/dom/base/nsDOMFileReader.cpp
index 6267e0e..fa22590 100644
--- a/dom/base/nsDOMFileReader.cpp
+++ b/dom/base/nsDOMFileReader.cpp
@@ -363,7 +363,7 @@ nsDOMFileReader::DoReadData(nsIAsyncInputStream* aStream, uint64_t aCount)
       return NS_ERROR_OUT_OF_MEMORY;
     }
     if (mDataFormat != FILE_AS_ARRAYBUFFER) {
-      mFileData = (char *) moz_realloc(mFileData, mDataLen + aCount);
+      mFileData = (char *) realloc(mFileData, mDataLen + aCount);
       NS_ENSURE_TRUE(mFileData, NS_ERROR_OUT_OF_MEMORY);
     }
 
$ git diff -U3 --color-words='[^ ()]' HEAD^ dom/base/nsDOMFileReader.cpp 
diff --git a/dom/base/nsDOMFileReader.cpp b/dom/base/nsDOMFileReader.cpp
index 6267e0e..fa22590 100644
--- a/dom/base/nsDOMFileReader.cpp
+++ b/dom/base/nsDOMFileReader.cpp
@@ -363,7 +363,7 @@ nsDOMFileReader::DoReadData(nsIAsyncInputStream* aStream, uint64_t aCount)
      return NS_ERROR_OUT_OF_MEMORY;
    }
    if (mDataFormat != FILE_AS_ARRAYBUFFER) {
      mFileData = (char *moz_) realloc(mFileData, mDataLen + aCount);
      NS_ENSURE_TRUE(mFileData, NS_ERROR_OUT_OF_MEMORY);
    }


(This is with 2.3.0)

Cheers,

Mike
