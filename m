From: madmarcos <fru574@my.utsa.edu>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sat, 16 Apr 2011 21:02:50 -0700 (PDT)
Message-ID: <1303012970295-6280285.post@n2.nabble.com>
References: <1302919505984-6278154.post@n2.nabble.com> <20110416063729.GC28853@sigill.intra.peff.net> <1302963832717-6279028.post@n2.nabble.com> <1302964576373-6279050.post@n2.nabble.com> <1302965899845-6279085.post@n2.nabble.com> <1302969047343-6279183.post@n2.nabble.com> <1303000824677-6280097.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 06:03:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBJCY-0006xV-LX
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 06:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab1DQECw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 00:02:52 -0400
Received: from sam.nabble.com ([216.139.236.26]:53006 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab1DQECv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 00:02:51 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QBJCE-0003L8-9w
	for git@vger.kernel.org; Sat, 16 Apr 2011 21:02:50 -0700
In-Reply-To: <1303000824677-6280097.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171712>

my entire testing class is below. just change the file path string in the
first line in test4.


package server_test2;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.zip.Inflater;

public class InflaterTest2 {

	public InflaterTest2() {
	}

	public void test4() {
		try {
			byte[] packFile = readFile2("/Users/marcos/GitProxyCache/jedit.pack");

			byte [] packDataWindow = new byte[8000];

			//the below object is the .classpath blob. works fine
			System.arraycopy(packFile, 4828 + 2, packDataWindow, 0,
packDataWindow.length); 

			//the below object is the .project blob. works fine
			//System.arraycopy(packFile, 4978 + 2, packDataWindow, 0,
packDataWindow.length); 
			
			//the below object is the top-level tree. works fine
			//System.arraycopy(packFile, 5171 + 2, packDataWindow, 0,
packDataWindow.length); 

			//the below object is source code notes blob. works fine
			//System.arraycopy(packFile, 5760 + 3, packDataWindow, 0,
packDataWindow.length); 

			//the below object is a build file blob. works fine
			//System.arraycopy(packFile, 8619, packDataWindow, 0,
packDataWindow.length); 
			
			//THE BELOW OBJECT FAILS TO INFLATE
			//IT CAUSES an "incorrect data check" error
       		//Object starts at index 9470
       		//Type = 3, Decompressed size = 51060 (uses 2 extra size bytes)
			//System.arraycopy(packFile, 9470 + 3, packDataWindow, 0,
packDataWindow.length); 

			Inflater decompresser = new Inflater();
			decompresser.setInput(packDataWindow, 0, packDataWindow.length);
			byte[] result = new byte[60000];
			int resultLength = 0;
			resultLength = decompresser.inflate(result);
			
			String outputString = new String(result, 0, resultLength, "UTF-8");
			System.out.println(outputString);

			System.out.println("------- End Decompressed Output -------");
			int numCompressed = (int) decompresser.getBytesRead();
			System.out.println("# Bytes Compressed: " + numCompressed);
			decompresser.end();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public byte [] readFile2(String fileName) {
		byte [] input2 = null;
	    File tempPackInputFile2 = new File(fileName);
		DataInputStream tempPackInputStream2;
		try {
			tempPackInputStream2 = new DataInputStream(new
FileInputStream(tempPackInputFile2));
			long tempPackLength2 = tempPackInputFile2.length();
			input2 = new byte[(int) tempPackLength2];
			tempPackInputStream2.readFully(input2);
		    tempPackInputStream2.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return input2;
	}

	public static void main(String[] args) {
		InflaterTest2 app = new InflaterTest2();
		app.test4();
		System.out.println("Done.");
	}

}

--
View this message in context: http://git.661346.n2.nabble.com/Java-Inflater-problem-decompressing-packfile-tp6278154p6280285.html
Sent from the git mailing list archive at Nabble.com.
