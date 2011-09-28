From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Merge seems to overwrite unstaged local changes
Date: Wed, 28 Sep 2011 16:08:15 +0200
Message-ID: <j5v9r7$fi1$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 16:10:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uqS-0004Aq-Bk
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab1I1OKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 10:10:42 -0400
Received: from lo.gmane.org ([80.91.229.12]:36476 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab1I1OKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 10:10:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R8uph-0003lM-Lx
	for git@vger.kernel.org; Wed, 28 Sep 2011 16:09:57 +0200
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 16:09:57 +0200
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 16:09:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182318>

Hi,

although it is good practice to have a clean working tree before pulling / merging, my understanding of

"In particular, the local modifications you had before you started merge will stay the same and the index entries for them stay as they were, i.e. matching HEAD."

from [1] is that my local unstaged changes to a file known to Git should not get lost during a merge (especially if there a no conflicts in the file that's modified locally).

It seems I can reproduce a case where this is not true. Here's what I do:

# Checkout a branch
$ git co -b marianne 45e0d23bf1a6bf62e3317a691385e0f1a7b279ea

$ git status
# On branch marianne
nothing to commit (working directory clean)

$ git log --oneline hxprofile1d/HxComputeProfileAlongAxis.cpp
45e0d23 hxprofile1d: [Fix] errors according to move of files
3509d94 hxprofile1d: moved files from package hxneuralnetwork to hxprofile1d

# Add some stuff to the end of the existing file.
$ vim hxprofile1d/HxComputeProfileAlongAxis.cpp

$ git status
# On branch marianne
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   hxprofile1d/HxComputeProfileAlongAxis.cpp
#
no changes added to commit (use "git add" and/or "git commit -a")

$ git merge 569e443faf5ae773af1c8eedfefa41ebfd066171
Removing cgal/BuildCGAL.sh
Auto-merging hxcortexinsilico/QxCorticalColumnTool.cpp
Auto-merging hxcortexinsilico/QxCorticalColumnTool.h
Removing hxneuralnetwork/QxAddFilesDialog.cpp
Removing hxneuralnetwork/QxAddFilesDialog.h
Removing hxneuralnetwork/QxAddFilesDialogUI.ui
Auto-merging hxneuralnetwork/SelectionPredicateCellTypeIsTest.cpp
Removing hxneuralnetwork/SelectionPredicateHasCellTypeName.cpp
Removing hxneuralnetwork/SelectionPredicateHasCellTypeName.h
Removing hxneuralnetwork/SelectionPredicateHasCellTypeNameTest.h
Auto-merging hxneuralnetwork/share/resources/hxneuralnetwork.rc
Auto-merging hxneuralnetwork/share/resources/test_hxneuralnetwork.rc
Auto-merging hxneuronkernels/HxLandmarksInSurface.h
Auto-merging hxneuronkernels/MeasurementFunctions.h
Merge made by recursive.
 cgal/BuildCGAL.sh                                  |  153 ----
 cgal/BuildCGALforLinux.sh                          |   94 ++
 cgal/Package                                       |   11 +-
 hx2d3drecon/Reg2d3dFunctionalEdgeNormal.cpp        |    5 +-
 .../ConnectEndNodesToSomaOperationSet.cpp          |    0
 .../ConnectEndNodesToSomaOperationSet.h            |    0
 hxcortexinsilico/Package                           |   27 +
 .../QxCorticalColumnTool.cpp                       |    5 +-
 .../QxCorticalColumnTool.h                         |   10 +-
 .../QxCorticalColumnTool.ui                        |    0
 hxcortexinsilico/hxcortexinsilicoAPI.h             |   14 +
 .../share/png/CorticalColumnTool.png               |  Bin 326 -> 326 bytes
 .../share/resources/hxcortexinsilico.rc            |    9 +
 hxcrosscorrelation/CCR.cpp                         |  415 +++++++++
 hxcrosscorrelation/CCR.h                           |  111 +++
 hxcrosscorrelation/CCR_hollowCylinder.cpp          |  209 +++++
 hxcrosscorrelation/CCR_hollowCylinder.h            |   80 ++
 hxcrosscorrelation/CCR_hollowSphere.cpp            |  164 ++++
 hxcrosscorrelation/CCR_hollowSphere.h              |   69 ++
 hxcrosscorrelation/CCR_plane.cpp                   |  196 ++++
 hxcrosscorrelation/CCR_plane.h                     |   77 ++
 hxcrosscorrelation/CCR_rotation.cpp                |  131 +++
 hxcrosscorrelation/CCR_rotation.h                  |   64 ++
 hxcrosscorrelation/CCR_scale.cpp                   |   59 ++
 hxcrosscorrelation/CCR_scale.h                     |   55 ++
 hxcrosscorrelation/CCR_solidCylinder.cpp           |  197 ++++
 hxcrosscorrelation/CCR_solidCylinder.h             |   76 ++
 hxcrosscorrelation/CCR_solidSphere.cpp             |  153 ++++
 hxcrosscorrelation/CCR_solidSphere.h               |   66 ++
 hxcrosscorrelation/CrossCorrelation.cpp            |  442 +++++++++
 hxcrosscorrelation/CrossCorrelation.h              |  103 +++
 hxcrosscorrelation/CrossCorrelation_cuda.cu        |  208 +++++
 hxcrosscorrelation/DataSplitter.cpp                |  339 +++++++
 hxcrosscorrelation/DataSplitter.h                  |   85 ++
 hxcrosscorrelation/HxCCRShow.cpp                   |   79 ++
 hxcrosscorrelation/HxCCRShow.h                     |   50 +
 hxcrosscorrelation/HxCrossCorrelation.cpp          |  316 +++++++
 hxcrosscorrelation/HxCrossCorrelation.h            |   81 ++
 hxcrosscorrelation/HxDataToSpreadsheet.cpp         |  100 ++
 hxcrosscorrelation/HxDataToSpreadsheet.h           |   58 ++
 hxcrosscorrelation/HxHollowCylinderToCCR.cpp       |  199 ++++
 hxcrosscorrelation/HxHollowCylinderToCCR.h         |   61 ++
 hxcrosscorrelation/HxHollowSphereToCCR.cpp         |  148 +++
 hxcrosscorrelation/HxHollowSphereToCCR.h           |   59 ++
 hxcrosscorrelation/HxPlaneToCCR.cpp                |  166 ++++
 hxcrosscorrelation/HxPlaneToCCR.h                  |   60 ++
 .../HxReferenceIndicesToData_scalar.cpp            |   84 ++
 .../HxReferenceIndicesToData_scalar.h              |   49 +
 .../HxReferenceIndicesToData_vector.cpp            |   88 ++
 .../HxReferenceIndicesToData_vector.h              |   50 +
 hxcrosscorrelation/HxSolidCylinderToCCR.cpp        |  194 ++++
 hxcrosscorrelation/HxSolidCylinderToCCR.h          |   61 ++
 hxcrosscorrelation/HxSolidSphereToCCR.cpp          |  143 +++
 hxcrosscorrelation/HxSolidSphereToCCR.h            |   59 ++
 hxcrosscorrelation/Package                         |    7 +
 hxcrosscorrelation/doc/HxCCRShow.doc               |   29 +
 .../doc/HxCCRShow_selectReference.png              |  Bin 0 -> 2071 bytes
 hxcrosscorrelation/doc/HxCrossCorrelation.doc      |   65 ++
 .../doc/HxCrossCorrelation_GPUDevice.png           |  Bin 0 -> 2327 bytes
 .../doc/HxCrossCorrelation_GPUMemory.png           |  Bin 0 -> 1956 bytes
 .../doc/HxCrossCorrelation_blockSize.png           |  Bin 0 -> 2012 bytes
 .../doc/HxCrossCorrelation_nrBlocks.png            |  Bin 0 -> 2149 bytes
 .../doc/HxCrossCorrelation_timerThreshold.png      |  Bin 0 -> 1404 bytes
 hxcrosscorrelation/doc/HxDataToSpreadSheet.doc     |   30 +
 .../doc/HxDataToSpreadSheet_threshold.png          |  Bin 0 -> 1296 bytes
 hxcrosscorrelation/doc/HxHollowCylinderToCCR.doc   |  123 +++
 .../HxHollowCylinderToCCR_cylinderParameter.png    |  Bin 0 -> 4826 bytes
 .../doc/HxHollowCylinderToCCR_defineForeground.png |  Bin 0 -> 4561 bytes
 .../doc/HxHollowCylinderToCCR_defineForground.png  |  Bin 0 -> 1918 bytes
 .../doc/HxHollowCylinderToCCR_increment.png        |  Bin 0 -> 2800 bytes
 .../doc/HxHollowCylinderToCCR_maskParameter.png    |  Bin 0 -> 4708 bytes
 .../doc/HxHollowCylinderToCCR_options.png          |  Bin 0 -> 4923 bytes
 .../doc/HxHollowCylinderToCCR_psiRange.png         |  Bin 0 -> 3649 bytes
 .../doc/HxHollowCylinderToCCR_smoothing.png        |  Bin 0 -> 2483 bytes
 .../doc/HxHollowCylinderToCCR_thetaRange.png       |  Bin 0 -> 3660 bytes
 .../doc/HxHollowCylinderToCCR_tiltAngles.png       |  Bin 0 -> 3577 bytes
 .../doc/HxHollowCylinderToCCR_tiltAxis.png         |  Bin 0 -> 2909 bytes
 .../doc/HxHollowCylinderToCCR_tiltType.png         |  Bin 0 -> 3667 bytes
 .../doc/HxHollowCylinderToCCR_voxelSize.png        |  Bin 0 -> 3218 bytes
 hxcrosscorrelation/doc/HxHollowSphereToCCR.doc     |   94 ++
 .../doc/HxHollowSphereToCCR_defineForground.png    |  Bin 0 -> 1918 bytes
 .../doc/HxHollowSphereToCCR_increment.png          |  Bin 0 -> 1406 bytes
 .../doc/HxHollowSphereToCCR_options.png            |  Bin 0 -> 2335 bytes
 .../doc/HxHollowSphereToCCR_scaleRange.png         |  Bin 0 -> 1773 bytes
 .../doc/HxHollowSphereToCCR_smoothing.png          |  Bin 0 -> 1255 bytes
 .../doc/HxHollowSphereToCCR_sphereParameter.png    |  Bin 0 -> 1977 bytes
 .../doc/HxHollowSphereToCCR_tiltAngles.png         |  Bin 0 -> 1810 bytes
 .../doc/HxHollowSphereToCCR_tiltAxis.png           |  Bin 0 -> 1831 bytes
 .../doc/HxHollowSphereToCCR_tiltType.png           |  Bin 0 -> 2018 bytes
 .../doc/HxHollowSphereToCCR_voxelSize.png          |  Bin 0 -> 1331 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR.doc            |  105 +++
 .../doc/HxPlaneToCCR_defineForground.png           |  Bin 0 -> 1918 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_increment.png  |  Bin 0 -> 1406 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_options.png    |  Bin 0 -> 2335 bytes
 .../doc/HxPlaneToCCR_planeParameter.png            |  Bin 0 -> 2574 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_psiRange.png   |  Bin 0 -> 1728 bytes
 .../doc/HxPlaneToCCR_subdivision.png               |  Bin 0 -> 1255 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_thetaRange.png |  Bin 0 -> 1748 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_tiltAngles.png |  Bin 0 -> 1810 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_tiltAxis.png   |  Bin 0 -> 1831 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_tiltType.png   |  Bin 0 -> 2018 bytes
 hxcrosscorrelation/doc/HxPlaneToCCR_voxelSize.png  |  Bin 0 -> 1331 bytes
 .../doc/HxReferenceIndicesToData_scalar.doc        |   27 +
 .../doc/HxReferenceIndicesToData_vector.doc        |   28 +
 hxcrosscorrelation/doc/HxSolidCylinderToCCR.doc    |  121 +++
 .../doc/HxSolidCylinderToCCR_cylinderParameter.png |  Bin 0 -> 4867 bytes
 .../doc/HxSolidCylinderToCCR_defineForeground.png  |  Bin 0 -> 4561 bytes
 .../doc/HxSolidCylinderToCCR_defineForground.png   |  Bin 0 -> 1918 bytes
 .../doc/HxSolidCylinderToCCR_increment.png         |  Bin 0 -> 2800 bytes
 .../doc/HxSolidCylinderToCCR_maskParameter.png     |  Bin 0 -> 4769 bytes
 .../doc/HxSolidCylinderToCCR_options.png           |  Bin 0 -> 4923 bytes
 .../doc/HxSolidCylinderToCCR_psiRange.png          |  Bin 0 -> 3649 bytes
 .../doc/HxSolidCylinderToCCR_smoothing.png         |  Bin 0 -> 2483 bytes
 .../doc/HxSolidCylinderToCCR_thetaRange.png        |  Bin 0 -> 3660 bytes
 .../doc/HxSolidCylinderToCCR_tiltAngles.png        |  Bin 0 -> 3577 bytes
 .../doc/HxSolidCylinderToCCR_tiltAxis.png          |  Bin 0 -> 2909 bytes
 .../doc/HxSolidCylinderToCCR_tiltType.png          |  Bin 0 -> 3667 bytes
 .../doc/HxSolidCylinderToCCR_voxelSize.png         |  Bin 0 -> 3218 bytes
 hxcrosscorrelation/doc/HxSolidSphereToCCR.doc      |   93 ++
 .../doc/HxSolidSphereToCCR_defineForground.png     |  Bin 0 -> 1918 bytes
 .../doc/HxSolidSphereToCCR_increment.png           |  Bin 0 -> 1406 bytes
 .../doc/HxSolidSphereToCCR_options.png             |  Bin 0 -> 2335 bytes
 .../doc/HxSolidSphereToCCR_scaleRange.png          |  Bin 0 -> 1773 bytes
 .../doc/HxSolidSphereToCCR_smoothing.png           |  Bin 0 -> 1255 bytes
 .../doc/HxSolidSphereToCCR_sphereParameter.png     |  Bin 0 -> 1699 bytes
 .../doc/HxSolidSphereToCCR_tiltAngles.png          |  Bin 0 -> 1810 bytes
 .../doc/HxSolidSphereToCCR_tiltAxis.png            |  Bin 0 -> 1831 bytes
 .../doc/HxSolidSphereToCCR_tiltType.png            |  Bin 0 -> 2018 bytes
 .../doc/HxSolidSphereToCCR_voxelSize.png           |  Bin 0 -> 1331 bytes
 hxcrosscorrelation/hxcrosscorrelationWinDLLAPI.h   |   19 +
 .../share/resources/hxcrosscorrelation.rc          |   74 ++
 .../script-objects/TraceFilamentsAndFilter.scro    |   82 ++-
 hxlineextraction/HxAngularDistribution.cpp         |  272 ++++++
 hxlineextraction/HxAngularDistribution.h           |   75 ++
 hxlineextraction/HxExtractLines.cpp                |  951 ++++++++++++++++++++
 hxlineextraction/HxExtractLines.h                  |  239 +++++
 hxlineextraction/HxLinesetToSpreadSheet.cpp        |  100 ++
 hxlineextraction/HxLinesetToSpreadSheet.h          |   51 ++
 hxlineextraction/Package                           |   10 +
 hxlineextraction/doc/HxAngularDistribution.doc     |   17 +
 hxlineextraction/doc/HxExtractLines.doc            |  122 +++
 hxlineextraction/doc/HxExtractLines_.png           |  Bin 0 -> 153 bytes
 .../doc/HxExtractLines_advancedMenu.png            |  Bin 0 -> 1465 bytes
 .../doc/HxExtractLines_cocircularity.png           |  Bin 0 -> 2227 bytes
 .../doc/HxExtractLines_coneAutoParameter.png       |  Bin 0 -> 1908 bytes
 hxlineextraction/doc/HxExtractLines_distance.png   |  Bin 0 -> 2006 bytes
 .../doc/HxExtractLines_getLabelFields.png          |  Bin 0 -> 2483 bytes
 hxlineextraction/doc/HxExtractLines_linearity.png  |  Bin 0 -> 2081 bytes
 hxlineextraction/doc/HxExtractLines_maskRadius.png |  Bin 0 -> 1486 bytes
 .../doc/HxExtractLines_minCorrelation.png          |  Bin 0 -> 2287 bytes
 .../doc/HxExtractLines_minLineLength.png           |  Bin 0 -> 1450 bytes
 hxlineextraction/doc/HxExtractLines_radius.png     |  Bin 0 -> 1355 bytes
 hxlineextraction/doc/HxExtractLines_scale.png      |  Bin 0 -> 1387 bytes
 .../doc/HxExtractLines_searchConeAngle.png         |  Bin 0 -> 1613 bytes
 .../doc/HxExtractLines_searchConeSize.png          |  Bin 0 -> 1710 bytes
 .../doc/HxExtractLines_similThreshold.png          |  Bin 0 -> 2172 bytes
 .../doc/HxExtractLines_similarityFactors.png       |  Bin 0 -> 2628 bytes
 .../doc/HxExtractLines_timerThreshold.png          |  Bin 0 -> 1972 bytes
 hxlineextraction/doc/HxLineSetToSpreadSheet.doc    |   17 +
 hxlineextraction/hxlineextractionWinDLLAPI.h       |   19 +
 .../share/resources/hxlineextraction.rc            |   17 +
 hxneuralnetwork/ASTToQueryVisitor.cpp              |   55 +-
 hxneuralnetwork/ASTToQueryVisitor.h                |   12 +-
 hxneuralnetwork/ASTVisitorTest.cpp                 |   54 +-
 hxneuralnetwork/ASTVisitorTest.h                   |    9 +-
 hxneuralnetwork/AbstractSyntaxTree.cpp             |   55 +-
 hxneuralnetwork/AbstractSyntaxTree.h               |   35 +-
 hxneuralnetwork/AbstractSyntaxTreeVisitor.h        |   10 +-
 hxneuralnetwork/HxCreateMorphologyGallery.cpp      |  199 +++--
 hxneuralnetwork/HxCreateMorphologyGallery.h        |   30 +-
 hxneuralnetwork/HxNeuralNetworkAnalyzer.cpp        |   75 ++-
 hxneuralnetwork/HxNeuralNetworkAnalyzer.h          |   14 +-
 hxneuralnetwork/HxNeuralNetworkAnalyzerTest.cpp    |    2 +-
 hxneuralnetwork/HxNeuralNetworkSubApp.cpp          |   14 +-
 hxneuralnetwork/HxNeuronDistributorTest.cpp        |   10 +-
 hxneuralnetwork/MorphologyManager.cpp              |   64 +-
 hxneuralnetwork/MorphologyManager.h                |   11 +-
 hxneuralnetwork/MorphologyManagerTest.cpp          |   37 +-
 hxneuralnetwork/MorphologyManagerTest.h            |    1 +
 hxneuralnetwork/NeuralNetworkDSLParser.l           |   10 +-
 hxneuralnetwork/NeuralNetworkDSLParser.y           |   84 ++-
 hxneuralnetwork/NeuralNetworkDSLParserTest.cpp     |   33 +-
 hxneuralnetwork/NeuralNetworkDSLParserTest.h       |   11 +-
 hxneuralnetwork/Package                            |    3 -
 hxneuralnetwork/PrintASTVisitor.cpp                |   27 +-
 hxneuralnetwork/PrintASTVisitor.h                  |    9 +-
 hxneuralnetwork/QxAddFilesDialog.cpp               |   55 --
 hxneuralnetwork/QxAddFilesDialog.h                 |   30 -
 hxneuralnetwork/QxAddFilesDialogUI.ui              |   85 --
 hxneuralnetwork/SelectionPredicateCellTypeIs.cpp   |   42 +
 hxneuralnetwork/SelectionPredicateCellTypeIs.h     |   24 +
 ...st.cpp => SelectionPredicateCellTypeIsTest.cpp} |   11 +-
 hxneuralnetwork/SelectionPredicateCellTypeIsTest.h |   18 +
 .../SelectionPredicateHasCellTypeName.cpp          |   27 -
 .../SelectionPredicateHasCellTypeName.h            |   21 -
 .../SelectionPredicateHasCellTypeNameTest.h        |   18 -
 hxneuralnetwork/SelectionPredicateTreeNode.cpp     |   21 +-
 hxneuralnetwork/SelectionPredicateTreeNode.h       |   16 +-
 hxneuralnetwork/SelectionQuery.cpp                 |   26 +-
 hxneuralnetwork/SelectionQuery.h                   |   25 +-
 hxneuralnetwork/SelectionQueryExecutor.cpp         |   73 ++-
 hxneuralnetwork/SelectionQueryExecutorTest.cpp     |   73 ++-
 hxneuralnetwork/SelectionQueryExecutorTest.h       |    6 +-
 hxneuralnetwork/SelectionQueryManager.cpp          |    2 +-
 hxneuralnetwork/SelectionQueryResult.cpp           |   13 +
 hxneuralnetwork/SelectionQueryResult.h             |    4 +
 hxneuralnetwork/TestHelpers.cpp                    |   16 +-
 hxneuralnetwork/share/resources/hxneuralnetwork.rc |   17 -
 .../share/resources/test_hxneuralnetwork.rc        |    2 +-
 .../HxLandmarksInSurface.cpp                       |    0
 .../HxLandmarksInSurface.h                         |    4 +-
 .../MeasurementFunctions.cpp                       |    0
 .../MeasurementFunctions.h                         |    4 +-
 hxneuronkernels/Package                            |    1 +
 hxneuronkernels/share/resources/hxneuronkernels.rc |    5 +
 hxoptimizeactiveshape2/GlobalOptimizeFunc.cpp      |  435 ++++++++--
 hxoptimizeactiveshape2/GlobalOptimizeFunc.h        |   51 +-
 hxoptimizeactiveshape2/GridSamples.cpp             |    2 +-
 hxoptimizeactiveshape2/HxGlobalOptimize.cpp        |    8 +-
 hxoptimizeactiveshape2/HxTestParameters.cpp        |    4 +-
 hxrabbitct/HxRabbitCTRunner.cpp                    |   54 +-
 hxrabbitct/HxRabbitCTRunner.h                      |    5 +-
 hxrabbitct/Package                                 |    2 -
 hxscanconvert/Bresenham.cpp                        |  152 ++++
 hxscanconvert/Bresenham.h                          |   31 +
 hxscanconvert/HxScanConvert.cpp                    |  202 +++++
 hxscanconvert/HxScanConvert.h                      |   83 ++
 hxscanconvert/HxScanConvertCylinder.cpp            |  110 +++
 hxscanconvert/HxScanConvertCylinder.h              |   37 +
 hxscanconvert/HxScanConvertCylinderHollow.cpp      |  165 ++++
 hxscanconvert/HxScanConvertCylinderHollow.h        |   37 +
 hxscanconvert/HxScanConvertPlane.cpp               |  111 +++
 hxscanconvert/HxScanConvertPlane.h                 |   37 +
 hxscanconvert/HxScanConvertSphere.cpp              |   97 ++
 hxscanconvert/HxScanConvertSphere.h                |   36 +
 hxscanconvert/HxScanConvertSphereHollow.cpp        |  155 ++++
 hxscanconvert/HxScanConvertSphereHollow.h          |   36 +
 hxscanconvert/Package                              |   10 +
 hxscanconvert/ScanConvert.cpp                      |  477 ++++++++++
 hxscanconvert/ScanConvert.h                        |  125 +++
 hxscanconvert/ScanConvertCylinder.cpp              |  159 ++++
 hxscanconvert/ScanConvertCylinder.h                |   51 ++
 hxscanconvert/ScanConvertPlane.cpp                 |   99 ++
 hxscanconvert/ScanConvertPlane.h                   |   56 ++
 hxscanconvert/ScanConvertSphere.cpp                |   76 ++
 hxscanconvert/ScanConvertSphere.h                  |   49 +
 hxscanconvert/hxscanconvertWinDLLAPI.h             |   19 +
 hxscanconvert/share/resources/hxscanconvert.rc     |   24 +
 .../HxSetSpatialGraphInterfaceImpl.cpp             |    2 +-
 hxspatialgraphset/HxSetSpatialGraphInterfaceImpl.h |    2 +-
 hxspatialgraphset/HxSpatialGraphSet.cpp            |    4 +-
 hxspatialgraphset/HxSpatialGraphSet.h              |    4 +-
 hxspatialgraphset/HxSpatialGraphSetLegend.cpp      |   45 +-
 hxspatialgraphset/HxSpatialGraphSetLegend.h        |    3 +-
 hxspatialgraphset/HxSpatialGraphSetView.cpp        |   92 ++-
 hxspatialgraphset/HxSpatialGraphSetView.h          |   15 +-
 .../QxSpatialGraphSetViewSelectionDialog.cpp       |   43 +-
 hxtemplatematching/HxRadonTransform.cpp            |    4 +-
 hxtensor3d/HxExtractTensorSlice.cpp                |   92 ++-
 hxtensor3d/HxExtractTensorSlice.h                  |    9 +
 hxtensor3d/HxStructureTensor.cpp                   |    4 +-
 hxtensor3dSegmentation/Package                     |    2 +-
 hxtensordisplay/HxTensorGlyphDisplay.cpp           |  418 +++++++++
 hxtensordisplay/HxTensorGlyphDisplay.h             |  132 +++
 hxtensordisplay/Package                            |   37 +-
 hxtensordisplay/share/resources/hxtensordisplay.rc |    6 +
 .../hxtensordisplay/HxTensorGlyphDisplay-Frag.glsl |   69 ++
 .../hxtensordisplay/HxTensorGlyphDisplay-Geom.glsl |  154 ++++
 .../HxTensorGlyphDisplay-Vertex.glsl               |  293 ++++++
 hxtensordisplay2d/HxTensorGlyphDisplay2D.cpp       |  151 ++--
 hxtensordisplay2d/HxTensorGlyphDisplay2D.h         |   54 +-
 hxtomtools/HxAverageSlices.cpp                     |  114 +++
 hxtomtools/HxAverageSlices.h                       |   61 ++
 hxtomtools/HxRemoveSmallSurfaces.cpp               |  247 +++++
 hxtomtools/HxRemoveSmallSurfaces.h                 |   73 ++
 hxtomtools/Package                                 |   10 +
 hxtomtools/doc/HxAverageSlices.doc                 |   27 +
 hxtomtools/doc/HxAverageSlices_numSlices.png       |  Bin 0 -> 1603 bytes
 hxtomtools/doc/HxRemoveSmallSurfaces.doc           |   28 +
 .../doc/HxRemoveSmallSurfaces_surfaceSize.png      |  Bin 0 -> 1614 bytes
 hxtomtools/hxtomtoolsWinDLLAPI.h                   |   19 +
 hxtomtools/share/resources/hxtomtools.rc           |   11 +
 282 files changed, 14158 insertions(+), 1084 deletions(-)
 delete mode 100755 cgal/BuildCGAL.sh
 create mode 100755 cgal/BuildCGALforLinux.sh
 rename {hxneuralnetwork => hxcortexinsilico}/ConnectEndNodesToSomaOperationSet.cpp (100%)
 rename {hxneuralnetwork => hxcortexinsilico}/ConnectEndNodesToSomaOperationSet.h (100%)
 create mode 100644 hxcortexinsilico/Package
 rename {hxneuralnetwork => hxcortexinsilico}/QxCorticalColumnTool.cpp (99%)
 rename {hxneuralnetwork => hxcortexinsilico}/QxCorticalColumnTool.h (96%)
 rename {hxneuralnetwork => hxcortexinsilico}/QxCorticalColumnTool.ui (100%)
 create mode 100644 hxcortexinsilico/hxcortexinsilicoAPI.h
 rename {hxneuralnetwork => hxcortexinsilico}/share/png/CorticalColumnTool.png (100%)
 create mode 100644 hxcortexinsilico/share/resources/hxcortexinsilico.rc
 create mode 100644 hxcrosscorrelation/CCR.cpp
 create mode 100644 hxcrosscorrelation/CCR.h
 create mode 100644 hxcrosscorrelation/CCR_hollowCylinder.cpp
 create mode 100644 hxcrosscorrelation/CCR_hollowCylinder.h
 create mode 100644 hxcrosscorrelation/CCR_hollowSphere.cpp
 create mode 100644 hxcrosscorrelation/CCR_hollowSphere.h
 create mode 100644 hxcrosscorrelation/CCR_plane.cpp
 create mode 100644 hxcrosscorrelation/CCR_plane.h
 create mode 100644 hxcrosscorrelation/CCR_rotation.cpp
 create mode 100644 hxcrosscorrelation/CCR_rotation.h
 create mode 100644 hxcrosscorrelation/CCR_scale.cpp
 create mode 100644 hxcrosscorrelation/CCR_scale.h
 create mode 100644 hxcrosscorrelation/CCR_solidCylinder.cpp
 create mode 100644 hxcrosscorrelation/CCR_solidCylinder.h
 create mode 100644 hxcrosscorrelation/CCR_solidSphere.cpp
 create mode 100644 hxcrosscorrelation/CCR_solidSphere.h
 create mode 100644 hxcrosscorrelation/CrossCorrelation.cpp
 create mode 100644 hxcrosscorrelation/CrossCorrelation.h
 create mode 100644 hxcrosscorrelation/CrossCorrelation_cuda.cu
 create mode 100644 hxcrosscorrelation/DataSplitter.cpp
 create mode 100644 hxcrosscorrelation/DataSplitter.h
 create mode 100644 hxcrosscorrelation/HxCCRShow.cpp
 create mode 100644 hxcrosscorrelation/HxCCRShow.h
 create mode 100644 hxcrosscorrelation/HxCrossCorrelation.cpp
 create mode 100644 hxcrosscorrelation/HxCrossCorrelation.h
 create mode 100644 hxcrosscorrelation/HxDataToSpreadsheet.cpp
 create mode 100644 hxcrosscorrelation/HxDataToSpreadsheet.h
 create mode 100644 hxcrosscorrelation/HxHollowCylinderToCCR.cpp
 create mode 100644 hxcrosscorrelation/HxHollowCylinderToCCR.h
 create mode 100644 hxcrosscorrelation/HxHollowSphereToCCR.cpp
 create mode 100644 hxcrosscorrelation/HxHollowSphereToCCR.h
 create mode 100644 hxcrosscorrelation/HxPlaneToCCR.cpp
 create mode 100644 hxcrosscorrelation/HxPlaneToCCR.h
 create mode 100644 hxcrosscorrelation/HxReferenceIndicesToData_scalar.cpp
 create mode 100644 hxcrosscorrelation/HxReferenceIndicesToData_scalar.h
 create mode 100644 hxcrosscorrelation/HxReferenceIndicesToData_vector.cpp
 create mode 100644 hxcrosscorrelation/HxReferenceIndicesToData_vector.h
 create mode 100644 hxcrosscorrelation/HxSolidCylinderToCCR.cpp
 create mode 100644 hxcrosscorrelation/HxSolidCylinderToCCR.h
 create mode 100644 hxcrosscorrelation/HxSolidSphereToCCR.cpp
 create mode 100644 hxcrosscorrelation/HxSolidSphereToCCR.h
 create mode 100644 hxcrosscorrelation/Package
 create mode 100644 hxcrosscorrelation/doc/HxCCRShow.doc
 create mode 100644 hxcrosscorrelation/doc/HxCCRShow_selectReference.png
 create mode 100644 hxcrosscorrelation/doc/HxCrossCorrelation.doc
 create mode 100644 hxcrosscorrelation/doc/HxCrossCorrelation_GPUDevice.png
 create mode 100644 hxcrosscorrelation/doc/HxCrossCorrelation_GPUMemory.png
 create mode 100644 hxcrosscorrelation/doc/HxCrossCorrelation_blockSize.png
 create mode 100644 hxcrosscorrelation/doc/HxCrossCorrelation_nrBlocks.png
 create mode 100644 hxcrosscorrelation/doc/HxCrossCorrelation_timerThreshold.png
 create mode 100644 hxcrosscorrelation/doc/HxDataToSpreadSheet.doc
 create mode 100644 hxcrosscorrelation/doc/HxDataToSpreadSheet_threshold.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR.doc
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_cylinderParameter.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_defineForeground.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_defineForground.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_increment.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_maskParameter.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_options.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_psiRange.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_smoothing.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_thetaRange.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_tiltAngles.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_tiltAxis.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_tiltType.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowCylinderToCCR_voxelSize.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR.doc
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_defineForground.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_increment.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_options.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_scaleRange.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_smoothing.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_sphereParameter.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_tiltAngles.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_tiltAxis.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_tiltType.png
 create mode 100644 hxcrosscorrelation/doc/HxHollowSphereToCCR_voxelSize.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR.doc
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_defineForground.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_increment.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_options.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_planeParameter.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_psiRange.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_subdivision.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_thetaRange.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_tiltAngles.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_tiltAxis.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_tiltType.png
 create mode 100644 hxcrosscorrelation/doc/HxPlaneToCCR_voxelSize.png
 create mode 100644 hxcrosscorrelation/doc/HxReferenceIndicesToData_scalar.doc
 create mode 100644 hxcrosscorrelation/doc/HxReferenceIndicesToData_vector.doc
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR.doc
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_cylinderParameter.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_defineForeground.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_defineForground.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_increment.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_maskParameter.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_options.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_psiRange.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_smoothing.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_thetaRange.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_tiltAngles.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_tiltAxis.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_tiltType.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidCylinderToCCR_voxelSize.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR.doc
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_defineForground.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_increment.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_options.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_scaleRange.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_smoothing.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_sphereParameter.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_tiltAngles.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_tiltAxis.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_tiltType.png
 create mode 100644 hxcrosscorrelation/doc/HxSolidSphereToCCR_voxelSize.png
 create mode 100644 hxcrosscorrelation/hxcrosscorrelationWinDLLAPI.h
 create mode 100644 hxcrosscorrelation/share/resources/hxcrosscorrelation.rc
 create mode 100644 hxlineextraction/HxAngularDistribution.cpp
 create mode 100644 hxlineextraction/HxAngularDistribution.h
 create mode 100644 hxlineextraction/HxExtractLines.cpp
 create mode 100644 hxlineextraction/HxExtractLines.h
 create mode 100644 hxlineextraction/HxLinesetToSpreadSheet.cpp
 create mode 100644 hxlineextraction/HxLinesetToSpreadSheet.h
 create mode 100644 hxlineextraction/Package
 create mode 100644 hxlineextraction/doc/HxAngularDistribution.doc
 create mode 100644 hxlineextraction/doc/HxExtractLines.doc
 create mode 100644 hxlineextraction/doc/HxExtractLines_.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_advancedMenu.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_cocircularity.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_coneAutoParameter.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_distance.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_getLabelFields.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_linearity.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_maskRadius.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_minCorrelation.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_minLineLength.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_radius.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_scale.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_searchConeAngle.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_searchConeSize.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_similThreshold.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_similarityFactors.png
 create mode 100644 hxlineextraction/doc/HxExtractLines_timerThreshold.png
 create mode 100644 hxlineextraction/doc/HxLineSetToSpreadSheet.doc
 create mode 100644 hxlineextraction/hxlineextractionWinDLLAPI.h
 create mode 100644 hxlineextraction/share/resources/hxlineextraction.rc
 delete mode 100644 hxneuralnetwork/QxAddFilesDialog.cpp
 delete mode 100644 hxneuralnetwork/QxAddFilesDialog.h
 delete mode 100644 hxneuralnetwork/QxAddFilesDialogUI.ui
 create mode 100644 hxneuralnetwork/SelectionPredicateCellTypeIs.cpp
 create mode 100644 hxneuralnetwork/SelectionPredicateCellTypeIs.h
 rename hxneuralnetwork/{SelectionPredicateHasCellTypeNameTest.cpp => SelectionPredicateCellTypeIsTest.cpp} (66%)
 create mode 100644 hxneuralnetwork/SelectionPredicateCellTypeIsTest.h
 delete mode 100644 hxneuralnetwork/SelectionPredicateHasCellTypeName.cpp
 delete mode 100644 hxneuralnetwork/SelectionPredicateHasCellTypeName.h
 delete mode 100644 hxneuralnetwork/SelectionPredicateHasCellTypeNameTest.h
 rename {hxneuralnetwork => hxneuronkernels}/HxLandmarksInSurface.cpp (100%)
 rename {hxneuralnetwork => hxneuronkernels}/HxLandmarksInSurface.h (92%)
 rename {hxneuralnetwork => hxneuronkernels}/MeasurementFunctions.cpp (100%)
 rename {hxneuralnetwork => hxneuronkernels}/MeasurementFunctions.h (83%)
 create mode 100644 hxscanconvert/Bresenham.cpp
 create mode 100644 hxscanconvert/Bresenham.h
 create mode 100644 hxscanconvert/HxScanConvert.cpp
 create mode 100644 hxscanconvert/HxScanConvert.h
 create mode 100644 hxscanconvert/HxScanConvertCylinder.cpp
 create mode 100644 hxscanconvert/HxScanConvertCylinder.h
 create mode 100644 hxscanconvert/HxScanConvertCylinderHollow.cpp
 create mode 100644 hxscanconvert/HxScanConvertCylinderHollow.h
 create mode 100644 hxscanconvert/HxScanConvertPlane.cpp
 create mode 100644 hxscanconvert/HxScanConvertPlane.h
 create mode 100644 hxscanconvert/HxScanConvertSphere.cpp
 create mode 100644 hxscanconvert/HxScanConvertSphere.h
 create mode 100644 hxscanconvert/HxScanConvertSphereHollow.cpp
 create mode 100644 hxscanconvert/HxScanConvertSphereHollow.h
 create mode 100644 hxscanconvert/Package
 create mode 100644 hxscanconvert/ScanConvert.cpp
 create mode 100644 hxscanconvert/ScanConvert.h
 create mode 100644 hxscanconvert/ScanConvertCylinder.cpp
 create mode 100644 hxscanconvert/ScanConvertCylinder.h
 create mode 100644 hxscanconvert/ScanConvertPlane.cpp
 create mode 100644 hxscanconvert/ScanConvertPlane.h
 create mode 100644 hxscanconvert/ScanConvertSphere.cpp
 create mode 100644 hxscanconvert/ScanConvertSphere.h
 create mode 100644 hxscanconvert/hxscanconvertWinDLLAPI.h
 create mode 100644 hxscanconvert/share/resources/hxscanconvert.rc
 create mode 100644 hxtensordisplay/HxTensorGlyphDisplay.cpp
 create mode 100644 hxtensordisplay/HxTensorGlyphDisplay.h
 create mode 100644 hxtensordisplay/share/shaders/hxtensordisplay/HxTensorGlyphDisplay-Frag.glsl
 create mode 100644 hxtensordisplay/share/shaders/hxtensordisplay/HxTensorGlyphDisplay-Geom.glsl
 create mode 100644 hxtensordisplay/share/shaders/hxtensordisplay/HxTensorGlyphDisplay-Vertex.glsl
 create mode 100644 hxtomtools/HxAverageSlices.cpp
 create mode 100644 hxtomtools/HxAverageSlices.h
 create mode 100644 hxtomtools/HxRemoveSmallSurfaces.cpp
 create mode 100644 hxtomtools/HxRemoveSmallSurfaces.h
 create mode 100644 hxtomtools/Package
 create mode 100644 hxtomtools/doc/HxAverageSlices.doc
 create mode 100644 hxtomtools/doc/HxAverageSlices_numSlices.png
 create mode 100644 hxtomtools/doc/HxRemoveSmallSurfaces.doc
 create mode 100644 hxtomtools/doc/HxRemoveSmallSurfaces_surfaceSize.png
 create mode 100644 hxtomtools/hxtomtoolsWinDLLAPI.h
 create mode 100644 hxtomtools/share/resources/hxtomtools.rc

$ git status
# On branch marianne
nothing to commit (working directory clean)

Do, although there were no conflicts during the merge, and the merge does not seem to touch hxprofile1d/HxComputeProfileAlongAxis.cpp, the local changes in that file are gone. I'm seeing this on Linux and Windows, with versions 1.7.4.3 and 1.7.6.

I'd say this is not expected, or am I missing something?

[1] http://manpages.ubuntu.com/manpages/oneiric/man1/git-merge.1.html

-- 
Sebastian Schuberth
